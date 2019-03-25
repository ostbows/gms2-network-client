///@description scr_cmd_move
///@arg {real} press_time : argument0
///@arg {Client} client : argument1

with argument1
{
	var input = ds_map_create();
	input[? "action"] = cmd.move;
	input[? "client_id"] = client_id;
	input[? "input_number"] = input_number++;
	input[? "press_time"] = argument0 / 1000000;
	
	buffer_seek(buffer, buffer_seek_start, 0);
	buffer_write(buffer, buffer_u8, input[? "action"]);
	buffer_write(buffer, buffer_u8, input[? "client_id"]);
	buffer_write(buffer, buffer_u16, input[? "input_number"]);
	buffer_write(buffer, buffer_f32, input[? "press_time"]);
	
	network_send_udp_raw(
		udp_client, server_ip, server_udp_port, buffer, buffer_tell(buffer)
	);
	
	ds_queue_enqueue(pending_inputs, input);
	
	return input;
}