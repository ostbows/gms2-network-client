///@description scr_apply_input
///@arg {ds_map} input
///@arg {Entity} entity

var input = argument0;
var entity = argument1;

with entity
{
	switch input[? "action"]
	{
		case cmd.move:
			x += input[? "press_time"] * spd;
			break;
	}
}