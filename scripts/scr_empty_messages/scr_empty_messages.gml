///@description scr_empty_messages
///@arg {ds_queue} messages : argument0
///@arg {boolean} destroy : argument1

while !ds_queue_empty(argument0)
{
	var message = ds_queue_dequeue(argument0);
	var n = ds_list_size(message);
			
	for (var i = 0; i < n; i++) {
		ds_map_destroy(message[| i]);
	}
			
	ds_list_destroy(message);
}

if argument1 {
	ds_queue_destroy(argument0);
}