///@description scr_parse_rpc
///@arg {ds_map} rpc

var rpc = argument0;

with Client {
	switch rpc[? RpcKey.type] {
		case RpcType.world_state:
			var message = scr_copy_world_state(rpc[? RpcKey.world_state[? "states"]]);
			ds_list_add(messages, message);
			show_debug_message("world state received with states: " + string(ds_list_size(message)));
			show_debug_message("pending inputs: " + string(ds_list_size(pending_inputs)));
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
}