// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function unit_attack(){
	if(instance_exists(target))
	{
		var dir = point_direction(x,y,target.x, target.y)
		unit_execute_turning(dir, unit_turn_rate_gs)
		
		//avoidance movement
		var proposed_avoidance = calculate_move_avoidance(self, ds_unit_context)
		//Clamp proposed avoidance to current_speed/2
		if (proposed_avoidance[0]*proposed_avoidance[0] + proposed_avoidance[1]*proposed_avoidance[1]>current_speed*current_speed/4){
			var av_dir = point_direction(0,0,proposed_avoidance[0], proposed_avoidance[1])
			proposed_avoidance[0] = lengthdir_x(current_speed/2, av_dir)
			proposed_avoidance[1] = lengthdir_x(current_speed/2, av_dir)
		
		}
		scr_unit_execute_movement_and_collision(proposed_avoidance[0], proposed_avoidance[1])
		image_angle = direction

		if(unit_attack_execution != -1)
		{
			scr_script_execute_array(unit_attack_execution, [])
	
		}
	
		//End the attack
		if ( image_index + (sprite_get_speed(sprite_index)/game_get_speed(gamespeed_fps)) >= image_number )
		{
			alarm[1] = unit_attack_cooldown * game_get_speed(gamespeed_fps)
			//reset state
			initialize_chase()
		
		}
	} else {
		initialize_chase()
	}
}

function initialize_attack(){
	state = unit_states.ATTACK
	attack_on_cooldown = true
	sprite_index = unit_state_sprite[state]
	image_index = 0
	if(unit_attack_setup != -1){
		scr_script_execute_array(unit_attack_setup, [])
	}
	
}