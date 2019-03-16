///@description scr_send_move
///@arg {string} press_time

with Client {
	var input = ds_map_create();
	show_debug_message("ds_map #" + string(input));
	
	ds_map_add(input, "cmd", "move");
	ds_map_add(input, "id", client_id);
	ds_map_add(input, "dt", argument0);
	ds_map_add(input, "i", string(input_number++));
	
	scr_udp_send(input);
	ds_list_add(pending_inputs, input);
	
	return input;
}