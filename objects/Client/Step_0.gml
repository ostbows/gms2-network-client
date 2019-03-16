if (keyboard_check_pressed(vk_space)) scr_tcp_connect();
if (client_id == "-1") exit;

scr_process_messages();
scr_process_input();