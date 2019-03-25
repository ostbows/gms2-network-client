///@description scr_apply_input
///@arg {ds_map} input : argument0
///@arg {Entity} entity : argument1

with argument1
{
	switch argument0[? "action"]
	{
		case cmd.move:
			var client_id = argument0[? "client_id"];
			
			var xx = x + argument0[? "press_time"] * spd;
			var right_edge = xx + sprite_width;
			
			with Entity
			{
				if entity_id != client_id
				{
					if xx < x + sprite_width && right_edge > x
					{
						if sign(argument0[? "press_time"]) < 0 {
							other.x = x + sprite_width;
						} else {
							other.x = x - other.sprite_width;
						}
						
						return;
					}
				}
			}
			
			x = xx;
			
			break;
	}
}