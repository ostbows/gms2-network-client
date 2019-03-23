var messages = argument0;
var destroy = argument1;

while !ds_queue_empty(messages) {
	var message = ds_queue_dequeue(messages);
	var n = ds_list_size(message);
			
	for (var i = 0; i < n; i++) {
		ds_map_destroy(message[| i]);
	}
			
	ds_list_destroy(message);
}

if destroy {
	ds_queue_destroy(messages);
}