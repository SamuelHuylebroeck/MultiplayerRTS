
//Check if there's no unit at the mouse position, and if there's not, clear the selection

switch(state){
	case player_states.FREE:
		if not position_meeting(mouse_x,mouse_y, p_unit){
			clear_selection()
			state = player_states.SELECTING
			pressed_x = mouse_x
			pressed_y = mouse_y
		}
		break;
}

