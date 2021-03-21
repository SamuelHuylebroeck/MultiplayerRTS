if active{
	//Move every member of the flock
	for(var i =0; i< ds_list_size(ds_flock_agents);i++){
		var flock_agent = ds_flock_agents[|i]
		var context_list = ds_list_create()
		get_context(flock_agent, context_list)
		var proposed_move = calculate_move(flock_agent, context_list)
		with(flock_agent){
			x += proposed_move[0]
			y += proposed_move[1]
			direction = point_direction(xprevious, yprevious, x,y)
			//scr_entity_execute_free_movement_and_collision(proposed_move[0], proposed_move[1])	
		}
		ds_list_destroy(context_list)

	}
}