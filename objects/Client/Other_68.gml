show_debug_message("pending inputs: " + string(ds_list_size(pending_inputs)));

var rpc = json_decode(buffer_read(async_load[? "buffer"], buffer_string));

if (rpc == -1) exit;

switch rpc[? RpcKey.type] {
	case RpcType.world_state:
		var message = scr_parse_world_state(rpc[? RpcKey.world_state[? "states"]]);
		ds_list_add(messages, message);
		show_debug_message("state received with entities: " + string(ds_list_size(message)));
		break;
	case RpcType.connected:
		client_id = string(rpc[? RpcKey.connected[? "client_id"]]);
		player = instance_create_layer(10, 10, "Instances", Entity);
		ds_map_add(entities, client_id, player);
		show_debug_message("connected with client id: " + client_id);
		break;
	case RpcType.disconnected:
		var entity_id = rpc[? RpcKey.disconnected[? "client_id"]];
		instance_destroy(entities[? entity_id]);
		ds_map_delete(entities, entity_id);
		show_debug_message("client #" + entity_id + " has disconnected");
		break;
}

ds_map_destroy(rpc);