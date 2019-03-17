///@description scr_send_cmd_move
///@arg {string} press_time

with Client {
	var input = ds_map_create();
	ds_map_add(input, CmdKey.type, CmdType.move);
	ds_map_add(input, CmdKey.client_id, client_id);
	ds_map_add(input, CmdKey.input_number, string(input_number++));
	ds_map_add(input, CmdKey.move[? "press_time"], string(argument0));
	
	scr_udp_send(input);
	
	ds_list_add(pending_inputs, input);
	
	return input;
}