switch(state){
	case player_states.SELECTING:
		//we got the box, now to select everything underneath
		var release_x = mouse_x
		var release_y = mouse_y
		select_units_in_rectangle(pressed_x, pressed_y, release_x, release_y)
		state = player_states.FREE
		break;
}