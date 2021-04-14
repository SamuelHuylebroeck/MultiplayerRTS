function swarm_weighted_movement_sum(weights, intermediate_results)
{
	var result = [0,0]
	for(var i = 0; i<array_length(intermediate_results); i++){
		var component_weight = weights[i]
		//Clamp the movement magnitude to the weight
		var intermediate_result = intermediate_results[i]
		var squared_magnitude = intermediate_result[0] * intermediate_result[0] + intermediate_result[1]*intermediate_result[1]
		if(squared_magnitude > component_weight*component_weight){
			var dir = point_direction(0,0,intermediate_result[0],intermediate_result[1])
			intermediate_result[0] = lengthdir_x(1, dir)
			intermediate_result[1] = lengthdir_y(1, dir)
		
		}
		result[0] += component_weight * intermediate_result[0]
		result[1] += component_weight * intermediate_result[1]
	
	}
	return result
}

function swarm_calculate_move_improved(swarm_agent, context,  weights){
	//calculate the component values
	var result_c_steered = calculate_move_steered_cohesion(swarm_agent, context, true)
	var result_al = calculate_move_alignment(swarm_agent, context, true)
	var result_av = calculate_move_avoidance(swarm_agent, context)
	var result_stay_in_radius = calculate_move_stay_in_radius(swarm_agent,context,self, swarm_radius, swarm_deadzone)
	
	var intermediate_results = [result_c_steered,result_al,result_av,result_stay_in_radius]
	var result = swarm_weighted_movement_sum(weights, intermediate_results)
	

	return result
}


function get_context(swarm, swarm_agent, context_list, include_obstructions){
	//get neighbouring units
	get_neighbours(swarm, swarm_agent, context_list)
	//get 8 directional neighbouring obstacles
	if(include_obstructions){
		get_neighbouring_obstructions(swarm_agent, context_list)
	}
}


function get_neighbours(swarm, swarm_agent, context_list){
	var neighbour_list = ds_list_create()
	with(swarm_agent){
		collision_circle_list(x, y, swarm_agent_neighbour_radius, p_unit, false, true, neighbour_list, false);
	}

	for(var i = 0; i<ds_list_size(neighbour_list);i++)
	{
		var neighbour = neighbour_list[|i]
		var part_of_swarm = false;
		if(swarm != noone and instance_exists(swarm))
		{
			part_of_swarm = (ds_list_find_index(swarm.ds_swarm_agents, neighbour.id) != -1)
		}
		var neigbour_context = {
			pos_x : neighbour.x,
			pos_y : neighbour.y,
			dir: neighbour.direction,
			is_obstacle: false,
			is_part_of_swarm: part_of_swarm
		}
		ds_list_add(context_list,neigbour_context)
	}
	ds_list_destroy(neighbour_list)
}

function get_neighbouring_obstructions(swarm_agent, context_list)
{
	for(var i = -1; i<2; i++){
		var pos_to_consider_x = swarm_agent.x+ swarm_agent.swarm_agent_neighbour_radius*swarm_agent.swarm_agent_avoidance_factor * cos(swarm_agent.direction + i*45)
		var pos_to_consider_y = swarm_agent.y+ swarm_agent.swarm_agent_neighbour_radius*swarm_agent.swarm_agent_avoidance_factor * sin(swarm_agent.direction + i*45)
		if(tilemap_get_at_pixel(swarm_agent.collision_map, pos_to_consider_x, pos_to_consider_y))
		{
			show_debug_message("Adding obstruction point from angle: " +string(i*45))
			var neigbour_context = {
				pos_x : pos_to_consider_x,
				pos_y : pos_to_consider_y,
				dir: 0,
				is_obstacle: true,
				is_part_of_swarm: false
			} 
			ds_list_add(context_list,neigbour_context)
		}
	}

}


function calculate_move_steered_cohesion(swarm_agent, context, only_members){

	if(ds_list_size(context) <= 0)
	{
		return [0,0]
	}
	var running_x = 0
	var running_y = 0
	var count = ds_list_size(context)
	for(var i = 0; i<ds_list_size(context);i++){
		
		var neighbour_context = context[|i]
		if(not only_members or neighbour_context.is_part_of_swarm)
		{
			running_x += neighbour_context.pos_x
			running_y += neighbour_context.pos_y
		}
	}
	running_x /= count
	running_y /=count
	
	var rel_x = running_x - swarm_agent.x
	var rel_y = running_y - swarm_agent.y
	//[rel_x, rel_y] needs to be smoothed out
	var spring_constant = 10
	var delta_t = 1/game_get_speed(gamespeed_fps)
	var current_dir = swarm_agent.direction
	var current = [lengthdir_x(1, current_dir),lengthdir_y(1, current_dir)]
	var target = [rel_x, rel_y]
	
	var result = smooth_damp_flocking(current, target, current,delta_t, spring_constant)
	
	return result
}	
	
function calculate_move_alignment(swarm_agent, context, only_members){
	if(ds_list_size(context) <= 0)
	{
		return [lengthdir_x(1,direction),lengthdir_y(1,direction)]
	}
	var running_x = 0
	var running_y = 0
	var count = ds_list_size(context)
	for(var i = 0; i<ds_list_size(context);i++){
		var neighbour_context = context[|i]
		if(not only_members or neighbour_context.is_part_of_swarm)
		{
			var context_direction = neighbour_context.dir
			running_x += lengthdir_x(1, context_direction)
			running_y += lengthdir_x(1, context_direction)
		}
	}
	running_x /= count
	running_y /= count
	
	return [running_x, running_y]
}

function calculate_move_avoidance(swarm_agent, context)
{
	if(ds_list_size(context) <= 0)
	{
		return [0,0]
	}
	var running_x = 0
	var running_y = 0
	var running_count = 0
	for(var i = 0; i<ds_list_size(context);i++){
		var context_pos = context[|i]
		if( point_distance(swarm_agent.x, swarm_agent.y, context_pos.pos_x, context_pos.pos_y) < swarm_agent.swarm_agent_neighbour_radius*swarm_agent.swarm_agent_avoidance_factor)
		{
			running_x += (swarm_agent.x -context_pos.pos_x )
			running_y += (swarm_agent.y -context_pos.pos_y)
			running_count++;
		}

	}
	if(running_count <= 0){
		return [0,0]
	}
	running_x /= running_count
	running_y /=running_count
	
	return [running_x, running_y]

}

function calculate_move_stay_in_radius(swarm_agent, context, center, radius, deadzone)
{
	var dist_to_center = point_distance(swarm_agent.x, swarm_agent.y, center.x, center.y)
	var center_offset_x  = center.x - swarm_agent.x
	var center_offset_y = center.y - swarm_agent.y
	var t = abs(dist_to_center /radius)
	
	if(t<deadzone or (swarm_agent.state != unit_states.MOVE and swarm_agent.state != unit_states.ATTACK_MOVE )){
		return [0,0]
	}
	var max_contrib = swarm_agent.unit_max_speed
	var proposed_x = center_offset_x*t
	var proposed_y = center_offset_y*t
	if(point_distance(0,0,proposed_x, proposed_y) > max_contrib)
	{
		var dir = point_direction(0,0,proposed_x, proposed_y)
		proposed_x = lengthdir_x(max_contrib, dir)
		proposed_y = lengthdir_y(max_contrib, dir)
		
	}
	
	return [proposed_x,proposed_y]

}