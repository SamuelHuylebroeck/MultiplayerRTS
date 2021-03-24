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

function calculate_move(swarm_agent, weights)
{
	
	ds_list_clear(ds_agent_context)
	get_context(swarm_agent, ds_agent_context)
	//Get the weighted sum
	var result_c_steered = calculate_move_steered_cohesion(swarm_agent, ds_agent_context,false)
	var result_al = calculate_move_alignment(swarm_agent, ds_agent_context,false)
	var result_av = calculate_move_avoidance(swarm_agent, ds_agent_context)
	var result_stay_in_radius = calculate_move_stay_in_radius(swarm_agent,ds_agent_context,self, swarm_radius, swarm_deadzone)
	

	var intermediate_results = [result_c_steered, result_al, result_av, result_stay_in_radius]
	var result = swarm_weighted_movement_sum(weights,intermediate_results)
	
	//Cap result magnitude to speed
	return result
}

function calculate_move_improved(swarm_agent, weights){
	//get the relevant contexts
	ds_list_clear(ds_agent_context)
	get_context(swarm_agent, ds_agent_context)
	//calculate the component values
	var result_c_steered = calculate_move_steered_cohesion(swarm_agent, ds_agent_context, true)
	var result_al = calculate_move_alignment(swarm_agent, ds_agent_context, true)
	var result_av = calculate_move_avoidance(swarm_agent, ds_agent_context)
	var result_stay_in_radius = calculate_move_stay_in_radius(swarm_agent,ds_agent_context,self, swarm_radius, swarm_deadzone)
	
	var intermediate_results = [result_c_steered,result_al,result_av,result_stay_in_radius]
	var result = swarm_weighted_movement_sum(weights, intermediate_results)
	

	return result


}

function get_swarm_context(swarm_agent, context_list){
	for (var i=0; i<ds_list_size(ds_swarm_agents);i++){
		var other_swarm_agent = ds_swarm_agents[|i]
		if(swarm_agent.id != other_swarm_agent.id){
			if(point_distance(swarm_agent.x, swarm_agent.y, other_swarm_agent.x, other_swarm_agent.y) < swarm_agent.swarm_agent_neighbour_radius)
			{
				var context_details = [other_swarm_agent.x, other_swarm_agent.y, other_swarm_agent.direction]
				ds_list_add(context_list, context_details)
			}
		}
	}
}

function get_obstacle_context(swarm_agent, obstacle_context){
	get_neighbours(swarm_agent, obstacle_context)
	//todo get 8 directional neighbouring obstacles

}


function get_context(swarm_agent, context_list){
	//get neighbouring units
	get_neighbours(swarm_agent, context_list)
	//get 8 directional neighbouring obstacles
	//get_neighbouring_obstructions(swarm_agent, context_list)
}


function get_neighbours(swarm_agent, context_list, only_members){
	var neighbour_list = ds_list_create()
	collision_circle_list(swarm_agent.x, swarm_agent.y, swarm_agent.swarm_agent_neighbour_radius, p_unit, false, true, neighbour_list, false);
	for(var i = 0; i<ds_list_size(neighbour_list);i++)
	{
		var neighbour = neighbour_list[|i]
		var part_of_swarm = (ds_list_find_index(ds_swarm_agents, neighbour.id) != -1)
		var neigbour_context = [neighbour.x,neighbour.y, neighbour.direction, part_of_swarm]
		ds_list_add(context_list,neigbour_context)
	}
	ds_list_destroy(neighbour_list)
}

function get_neighbouring_obstructions(swarm_agent, context_list)
{
	var neighbour_list = ds_list_create()
	collision_circle_list(swarm_agent.x, swarm_agent.y, swarm_agent.swarm_agent_neighbour_radius, p_obstruction, false, true, neighbour_list, false);
	for(var i = 0; i<ds_list_size(neighbour_list);i++)
	{
		var neighbour = neighbour_list[|i]
		var pos = [neighbour.x + neighbour.sprite_width/2, neighbour.y + neighbour.sprite_height/2, 0, false]
		ds_list_add(context_list,pos)
	}
	ds_list_destroy(neighbour_list)

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
		if(not only_members or neighbour_context[3])
		{
			running_x += neighbour_context[0]
			running_y += neighbour_context[1]
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
		if(not only_members or neighbour_context[3])
		{
			var context_direction = neighbour_context[2]
			running_x += lengthdir_x(1, context_direction)
			running_y += lengthdir_x(1, context_direction)
		}
	}
	running_x /= count
	running_y /=count
	
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
		if( point_distance(swarm_agent.x, swarm_agent.y, context_pos[0], context_pos[1]) < swarm_agent.swarm_agent_neighbour_radius*swarm_agent.swarm_agent_avoidance_factor)
		{
			running_x += (swarm_agent.x -context_pos[0] )
			running_y += (swarm_agent.y -context_pos[1])
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
	var t = dist_to_center /radius
	
	if(t<deadzone){
		return [0,0]
	}
	return [center_offset_x*t*t, center_offset_y*t*t]

}