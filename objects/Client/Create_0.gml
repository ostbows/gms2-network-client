show_debug_message("room speed: " + string(room_speed));

tcp_client = -1;
udp_client = -1;
w_buffer = buffer_create(1, buffer_grow, 1);

client_id = "-1";
server_ip = "127.0.0.1";
server_tcp_port = "2222";
server_udp_port = "41234";

key_left = false;
key_right = false;
input_number = 0;
input_reset_timer = 0;

entities = scr_ds_map_create();
messages = scr_ds_list_create();
pending_inputs = scr_ds_list_create();