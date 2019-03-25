#region check connection
if keyboard_check_pressed(vk_space)
{
	if client_id != "-1"
	{
		client_id = "-1";
		input_number = 0;
		
		network_destroy(tcp_client);
		network_destroy(udp_client);
	
		with Entity instance_destroy(id);
		ds_map_clear(entities);
		ds_queue_clear(disconnected);
		scr_empty_messages(messages, false);
		scr_empty_pending_inputs(pending_inputs, false);
	}
	else
	{
		tcp_client = network_create_socket(network_socket_tcp);
		udp_client = network_create_socket(network_socket_udp);
	
		network_connect_raw(tcp_client, server_ip, server_tcp_port);
	}
}
#endregion
#region process messages
while !ds_queue_empty(messages)
{
	var message = ds_queue_dequeue(messages);
	var n = ds_list_size(message);
		
	for (var i = 0; i < n; i++)
	{
		var state = message[| i];
		var entity_id = state[? "client_id"];
		var entity = entities[? entity_id];
			
		if is_undefined(entity)
		{
			entity = instance_create_layer(10, 10, "Instances", Entity);
			entity.entity_id = entity_id;
			
			ds_map_add(entities, entity_id, entity);
		}
			
		if entity_id == client_id
		{
			entity.x = state[? "pos_x"];
				
			var j = 0;
			var last_processed_input = state[? "last_processed_input"];
				
			while j < ds_queue_size(pending_inputs)
			{
				var input = ds_queue_head(pending_inputs);
					
				if input[? "input_number"] <= last_processed_input
				{
					ds_map_destroy(input);
					ds_queue_dequeue(pending_inputs);
				}
				else
				{
					scr_apply_input(input, entity);
					j++;
				}
			}
		}
		else
		{
			var position_buffer = ds_list_create();
			ds_list_add(position_buffer, current_time);
			ds_list_add(position_buffer, state[? "pos_x"]);
			ds_list_add(entity.position_buffer, position_buffer);
		}
			
		ds_map_destroy(state);
	}
		
	ds_list_destroy(message);
}
#endregion
#region process input
press_time += delta_time;
check_input = !check_input;

if check_input && client_id != "-1" {
	key_left = keyboard_check(vk_left);
	key_right = keyboard_check(vk_right);

	if key_right - key_left != 0 {
		var input = scr_cmd_move(key_left ? -press_time : press_time, self);
		scr_apply_input(input, entities[? client_id]);
	}
	
	press_time = 0;
}
#endregion
#region interpolate entities
var render_timestamp = current_time - 1000 / server_update_rate;

with Entity {
	if self.entity_id == other.client_id {
		continue;
	}
	
	var pb = self.position_buffer;
	
	while ds_list_size(pb) >= 2
	{
		var p1 = pb[|1];
		var t1 = p1[|0];
		
		if t1 <= render_timestamp {
			ds_list_delete(pb, 0);
		} else {
			var p0 = pb[|0];
			var t0 = p0[|0];
		
			if t0 <= render_timestamp && render_timestamp <= t1
			{
				var x0 = p0[|1];
				var x1 = p1[|1];
			
				self.x = x0 + (x1 - x0) * (render_timestamp - t0) / (t1 - t0);
			}
			
			break;
		}
	}
}
#endregion