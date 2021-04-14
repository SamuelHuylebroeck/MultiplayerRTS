switch(state){
	case player_states.FREE:
		var nr_currently_selected_units = ds_list_size(selected_units)
		if nr_currently_selected_units > 0 
		{
			if global.connected 
			{
				send_movement_order(mouse_x, mouse_y, selected_units)
			}else
			{
				switch(order_state)
				{
					case order_states.ATTACK:
						create_attack_move_order(mouse_x, mouse_y, selected_units)
						order_state = order_states.MOVE
						break;
					default:
						create_move_order(mouse_x, mouse_y, selected_units)
						break;
				}
			}
		}
		break;
	default:
		break;
}