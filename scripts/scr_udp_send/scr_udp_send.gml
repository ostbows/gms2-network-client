///@description scr_udp_send
///@arg {ds_map} map
 
with (Client) {
	buffer_seek(w_buffer, buffer_seek_start, 0);
	buffer_write(w_buffer, buffer_string, json_encode(argument0));
	network_send_udp_raw(udp_client, server_ip, server_udp_port, w_buffer, buffer_tell(w_buffer));
}