var state_key = RpcKey.world_state[? "state"];

with Client {
	var message_count = ds_list_size(messages);
	
	for (var z = 0; z < message_count; z++) {
		var message = messages[| z];
		var state_count = ds_list_size(message);

		for (var i = 0; i < state_count; i++) {
			var state = message[| i];
			var entity_id = state[? state_key[? "entity_id"]];
			var entity = entities[? entity_id];

			if (is_undefined(entity)) {
				entity = instance_create_layer(10, 10, "Instances", Entity);
				ds_map_add(entities, entity_id, entity);
			}

			if (entity_id == client_id) {
				entity.x = state[? state_key[? "pos_x"]];
				
				var last_processed_input = real(state[? state_key[? "last_processed_input"]]);
				
				var j = 0; while (j < ds_list_size(pending_inputs)) {
					var input = pending_inputs[| j];
					
					if (real(input[? CmdKey.input_number]) <= last_processed_input) {
						ds_map_destroy(input);
						ds_list_delete(pending_inputs, j);
					} else {
						scr_apply_input(input);
						j++;
					}
				}
			} else {
				entity.x = state[? state_key[? "pos_x"]];
			}
			
			ds_map_destroy(state);
		}

		ds_list_destroy(message);
		ds_list_delete(messages, z);
	}
}