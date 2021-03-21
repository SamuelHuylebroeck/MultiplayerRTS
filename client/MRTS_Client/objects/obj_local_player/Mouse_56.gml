switch(state){
	case player_states.SELECTING:
		//we got the box, now to select everything underneath
		var release_x = mouse_x
		var release_y = mouse_y
		var local_player = noone
		if(global.connected)
		{
			local_player = con_client.local_player
		}else{
			local_player = obj_local_game.local_player
		}
		
		select_units_in_rectangle(pressed_x, pressed_y, release_x, release_y, local_player)
		state = player_states.FREE
		break;
}