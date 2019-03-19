///@description scr_copy_world_state
///@arg {ds_list} states

var states = argument0;
var message = ds_list_create();

var i = 0; repeat (ds_list_size(states)) {
	var state = ds_map_create();
	ds_map_copy(state, states[| i++]);
	ds_list_add(message, state);
}

return message;