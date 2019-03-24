///@description scr_apply_input
///@arg {ds_map} input : argument0
///@arg {Entity} entity : argument1

switch argument0[? "action"]
{
	case cmd.move:
		argument1.x += argument0[? "press_time"] * argument1.spd;
		break;
}