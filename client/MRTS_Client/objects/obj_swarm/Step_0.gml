if swarm_active{
	//Move every member of the flock
	for(var i =0; i< ds_list_size(ds_swarm_agents);i++){
		var swarm_agent = ds_swarm_agents[|i]
		var context_list = ds_list_create()
		get_context(swarm_agent, context_list)
		var proposed_move = [0,0]
		proposed_move = calculate_move_improved(swarm_agent, swarm_weights)
		with(swarm_agent){
			if(proposed_move[0]*proposed_move[0]* + proposed_move[1]*proposed_move[1]> current_speed*current_speed)
			{
				var dir = point_direction(0,0,proposed_move[0], proposed_move[1])
				proposed_move[0] = lengthdir_x(current_speed, dir)
				proposed_move[1] = lengthdir_y(current_speed, dir)
			
			}
			
			scr_unit_execute_movement_and_collision(proposed_move[0], proposed_move[1])	
		}
		ds_list_destroy(context_list)

	}
}