///@description scr_empty_pending_inputs
///@arg {ds_queue} pending_inputs : argument0
///@arg {boolean} destroy : argument1

while !ds_queue_empty(argument0) {
	ds_map_destroy(ds_queue_dequeue(argument0));
}

if argument1 {
	ds_queue_destroy(argument0);
}