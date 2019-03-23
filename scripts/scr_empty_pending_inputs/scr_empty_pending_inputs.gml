var pending_inputs = argument0;
var destroy = argument1;

while !ds_queue_empty(pending_inputs) {
	ds_map_destroy(ds_queue_dequeue(pending_inputs));
}

if destroy {
	ds_queue_destroy(pending_inputs);
}