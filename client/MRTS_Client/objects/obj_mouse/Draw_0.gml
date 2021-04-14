if(local_player != noone){
	switch(local_player.order_state){
		case order_states.ATTACK:
			image_index = 1;
			break;
		case order_states.MOVE:
		default:
			image_index = 0;
			break;
	}
}
draw_self();