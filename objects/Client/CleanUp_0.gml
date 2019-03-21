network_destroy(tcp_client);
network_destroy(udp_client);
buffer_delete(buffer);
ds_map_destroy(entities);

while !ds_queue_empty(messages) {
	var message = ds_queue_dequeue(messages);
	var n = ds_list_size(message);
			
	for (var i = 0; i < n; i++) {
		ds_map_destroy(message[| i]);
	}
			
	ds_list_destroy(message);
} ds_queue_destroy(messages);

while !ds_queue_empty(pending_inputs) {
	ds_map_destroy(ds_queue_dequeue(pending_inputs));
} ds_queue_destroy(pending_inputs);