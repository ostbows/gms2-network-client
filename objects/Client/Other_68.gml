var r_buffer = async_load[? "buffer"];
var action = buffer_read(r_buffer, buffer_u8);

switch action
{
	#region world state
	case rpc.world_state:
		var message = ds_list_create();
		var n = (buffer_get_size(r_buffer) - 1) / 8;
		
		for (var i = 0; i < n; i++) {
			var state = ds_map_create();
			ds_map_add(state, "client_id", string(buffer_read(r_buffer, buffer_u8)));
			ds_map_add(state, "pos_x", buffer_read(r_buffer, buffer_f32));
			ds_map_add(state, "last_processed_input", buffer_read(r_buffer, buffer_u16));
			ds_list_add(message, state);
			
			buffer_read(r_buffer, buffer_s8); // contains -1 to mark the end
		}
		
		ds_queue_enqueue(messages, message);
		
		break;
	#endregion
	#region disonnected
	case rpc.disconnected:
		var entity_id = string(buffer_read(r_buffer, buffer_u8));
		show_debug_message("client #" + entity_id + " has disconnected");
		
		instance_destroy(entities[? entity_id]);
		ds_map_delete(entities, entity_id);
		
		break;
	#endregion
	#region connected
	case rpc.connected:
		client_id = string(buffer_read(r_buffer, buffer_u8));
		server_update_rate = buffer_read(r_buffer, buffer_u8);
		show_debug_message("connected with client id: " + client_id);
		show_debug_message("server update rate: " + string(server_update_rate));
		
		var entity = instance_create_layer(10, 10, "Instances", Entity);
		entity.entity_id = client_id;
		
		ds_map_add(entities, client_id, entity);
		
		break;
	#endregion
}