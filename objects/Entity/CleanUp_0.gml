while !ds_queue_empty(position_buffer) {
	ds_list_destroy(ds_queue_dequeue(position_buffer));
} ds_queue_destroy(position_buffer);