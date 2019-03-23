var n = ds_list_size(position_buffer);

for (var i = 0; i < n; i++) {
	ds_list_destroy(position_buffer[| i]);
}

ds_list_destroy(position_buffer);