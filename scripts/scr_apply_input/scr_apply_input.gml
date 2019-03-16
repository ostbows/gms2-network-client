///@description scr_apply_input
///@arg {ds_map} input

with Client.entities[? argument0[? "id"]] {
	switch argument0[? "cmd"] {
		case "move":
			x += (real(argument0[? "dt"])/1000) * spd;
			break;
	}
}