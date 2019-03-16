with Client {
	if (client_id != "-1") {
		network_destroy(tcp_client);
		network_destroy(udp_client);
	
		with Entity instance_destroy(id);
	
		ds_map_clear(entities);
		ds_list_clear(messages);
		ds_list_clear(pending_inputs);
		
		client_id = "-1"
		input_number = 0;
		input_reset_timer = 0;
	} else {
		tcp_client = network_create_socket(network_socket_tcp);
		udp_client = network_create_socket(network_socket_udp);
	
		network_connect_raw(tcp_client, server_ip, server_tcp_port);
	}
}