//Check if there's no unit at the mouse position, and if there's not, clear the selection
switch(state){
	case player_states.FREE:
		switch(order_state){
			case order_states.ATTACK:
				create_attack_move_order(mouse_x, mouse_y, selected_units)
				order_state = order_states.MOVE
				break;
			case order_states.MOVE:
				if not position_meeting(mouse_x,mouse_y, p_unit)
				{
					clear_selection()
					state = player_states.SELECTING
					pressed_x = mouse_x
					pressed_y = mouse_y
				}
		}
}

