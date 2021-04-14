function swarm_execute_movement()
{
	for(var i =0; i< ds_list_size(ds_swarm_agents);i++){
		var swarm_agent = ds_swarm_agents[|i]
		if(instance_exists(swarm_agent))
		{
			if swarm_agent.state = unit_states.MOVE or swarm_agent.state = unit_states.ATTACK_MOVE
			{
				var context_list = ds_list_create()
				get_context(self, swarm_agent, context_list)
				var proposed_move = [0,0]
				proposed_move = swarm_calculate_move_improved(swarm_agent, swarm_weights)
				//proposed_move = calculate_move_experimental(swarm_agent, swarm_weights)
				with(swarm_agent){
			
					var dir = point_direction(0,0,proposed_move[0], proposed_move[1])
					//show_debug_message("Direction: " +string(dir) + "Speed: " + string(point_distance(0,0,proposed_move[0], proposed_move[1])))
					if(proposed_move[0]*proposed_move[0]* + proposed_move[1]*proposed_move[1]> current_speed*current_speed)
					{
						proposed_move[0] = lengthdir_x(current_speed, dir)
						proposed_move[1] = lengthdir_y(current_speed, dir)
			
					}
					scr_unit_execute_movement_and_collision(proposed_move[0], proposed_move[1])	
				}
				ds_list_destroy(context_list)
			}
		}else{
			ds_list_delete(ds_swarm_agents, i)
		}
	}
}