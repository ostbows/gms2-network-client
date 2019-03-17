///@description scr_parse_data
///@arg {ds_list} world_state
///@return {ds_list} message
 
var message = ds_list_create();

for (var i = 0; i < ds_list_size(argument0); i++) {
	var state = ds_map_create();
	
	ds_map_copy(state, argument0[| i]);
	ds_list_add(message, state);
}

return message;