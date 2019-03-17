show_debug_message("pending inputs: " + string(ds_list_size(pending_inputs)));

var res = json_decode(buffer_read(async_load[? "buffer"], buffer_string));

if (res == -1) exit;

switch res[? "rpc"] {
	case "state":
		var message = scr_parse_world_state(res[? "state"]);
		ds_list_add(messages, message);
		show_debug_message("state received with entities: " + string(ds_list_size(message)));
		break;
	case "connected":
		client_id = string(res[? "id"]);
		player = instance_create_layer(10, 10, "Instances", Entity);
		ds_map_add(entities, client_id, player);
		show_debug_message("connected with client id: " + client_id);
		break;
	case "disconnect":
		var entity_id = res[? "id"];
		instance_destroy(entities[? entity_id]);
		ds_map_delete(entities, entity_id);
		show_debug_message("client #" + entity_id + " has disconnected");
		break;
}

ds_map_destroy(res);