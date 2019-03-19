with Client {
	var press_time = delta_time/1000;
	
	key_left = keyboard_check(vk_left);
	key_right = keyboard_check(vk_right);

	if (key_right - key_left != 0) {
		scr_apply_input(
			scr_cmd_move_send(key_left ? -press_time : press_time)
		);
		
		input_reset_timer = 0;
	} else {
		input_reset_timer -= press_time;
		
		if (input_reset_timer <= 0) {
			input_reset_timer = 3000;
			
			if (ds_list_size(pending_inputs) == 0) {
				input_number = 0;
			}
			
			scr_cmd_move_send(0)
		}
	}
}