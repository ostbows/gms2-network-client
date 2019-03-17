///@description scr_apply_input
///@arg {ds_map} input

with Client.player {
	switch argument0[? CmdKey.type] {
		case CmdType.move:
			x += (real(argument0[? CmdKey.move[? "press_time"]])/1000) * spd;
			break;
	}
}