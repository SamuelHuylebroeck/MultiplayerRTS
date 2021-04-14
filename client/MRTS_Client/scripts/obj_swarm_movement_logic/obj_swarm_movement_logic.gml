function swarm_execute_movement()
{
	for(var i =0; i< ds_list_size(ds_swarm_agents);i++){
		var swarm_agent = ds_swarm_agents[|i]
		if(instance_exists(swarm_agent))
		{
			if swarm_agent.state = unit_states.MOVE or swarm_agent.state = unit_states.ATTACK_MOVE
			{
				var proposed_move = [0,0]
				proposed_move = swarm_calculate_move_improved(swarm_agent,swarm_agent.ds_unit_context, swarm_weights)
				//proposed_move = calculate_move_experimental(swarm_agent, swarm_weights)
				with(swarm_agent){
			
					var dir = point_direction(0,0,proposed_move[0], proposed_move[1])
					//show_debug_message("Direction: " +string(dir) + "Speed: " + string(point_distance(0,0,proposed_move[0], proposed_move[1])))
					if(proposed_move[0]*proposed_move[0]* + proposed_move[1]*proposed_move[1]> current_speed*current_speed)
					{
						//show_debug_message(string(swarm_agent.id) + "is limiting speed")
						proposed_move[0] = lengthdir_x(current_speed, dir)
						proposed_move[1] = lengthdir_y(current_speed, dir)
					}
					scr_unit_execute_movement_and_collision(proposed_move[0], proposed_move[1])	
				}
			}
		}else{
			ds_list_delete(ds_swarm_agents, i)
		}
	}
}