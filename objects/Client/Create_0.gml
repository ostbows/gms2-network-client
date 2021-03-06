client_id = "-1";
server_ip = "127.0.0.1";
server_tcp_port = "2222";
server_udp_port = "41234";
server_update_rate = 0;
tcp_client = -1;
udp_client = -1;

buffer = buffer_create(256, buffer_grow, 1);
entities = ds_map_create();
messages = ds_queue_create();
pending_inputs = ds_queue_create();
disconnected = ds_queue_create();

check_input = true;
key_left = false;
key_right = false;
press_time = 0;
input_number = 0;

enum cmd {
	move
}

enum rpc {
	world_state,
	disconnected,
	connected
}