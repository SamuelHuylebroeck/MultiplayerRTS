/// @description Set units to Hold position mode
/// @description Set units to guard mode
switch(state){
	case player_states.FREE:
		var nr_currently_selected_units = ds_list_size(selected_units)
		if nr_currently_selected_units > 0 
		{
			if global.connected 
			{
				//send_movement_order(mouse_x, mouse_y, selected_units)
			}else
			{
				for(var i = 0; i< ds_list_size(selected_units); i++)
				{
					var selected_unit = selected_units[|i]
					selected_unit.unit_default_state = unit_states.IDLE
				}
			}
		}
		break;
	default:
		break;
}

