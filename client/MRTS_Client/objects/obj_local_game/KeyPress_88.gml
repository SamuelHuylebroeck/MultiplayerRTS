if (not global.connected )
{
	var local_player = obj_local_game.local_player
	if local_player.state = player_states.FREE
	{
		//create a hornet
		var hornet = instance_create_layer(mouse_x, mouse_y,"Instances", un_hornet)
		hornet.controlling_player = local_player.id
		with(hornet){
			//scr_unit_execute_movement_and_collision()
		}
	}
}