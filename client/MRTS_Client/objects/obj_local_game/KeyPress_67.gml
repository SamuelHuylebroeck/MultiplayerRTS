/// @description Debug: Spawn idle enemy hornet
if (not global.connected )
{
	var enemy_player = obj_local_game.enemy_player
	//create a hornet
	var hornet = instance_create_layer(mouse_x, mouse_y,"Instances", un_hornet)
	hornet.controlling_player = enemy_player.id
	hornet.state = unit_states.GUARD
	with(hornet){
		scr_unit_execute_movement_and_collision(0,0)
	}

}