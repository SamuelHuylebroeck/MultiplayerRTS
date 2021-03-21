function calculate_move(flock_agent, context)
{
	
	//Get the weighted sum
	var result_c = calculate_move_cohesion(flock_agent, context)
	var result_c_steered = calculate_move_steered_cohesion(flock_agent, context)
	var result_al = calculate_move_alignment(flock_agent, context)
	var result_av = calculate_move_avoidance(flock_agent, context)
	var result_stay_in_radius = calculate_move_stay_in_radius(flock_agent,context,self, radius, deadzone)
	
	var weights = [1,1,3,3]
	var result = [0,0]
	var intermediate_results = [result_c_steered, result_al, result_av, result_stay_in_radius]
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


function get_context(flock_agent, context_list){
	//get neighbouring units
	get_neighbours(flock_agent, context_list)
	//get 8 directional neighbouring obstacles
	//get_neighbouring_obstructions(flock_agent, context_list)
}

function get_neighbours(flock_agent, context_list){
	var neighbour_list = ds_list_create()
	collision_circle_list(flock_agent.x, flock_agent.y, flock_agent.flock_agent_neighbour_radius, p_unit, false, true, neighbour_list, false);
	for(var i = 0; i<ds_list_size(neighbour_list);i++)
	{
		var neighbour = neighbour_list[|i]
		var pos_and_dir = [neighbour.x,neighbour.y, neighbour.direction,1]
		ds_list_add(context_list,pos_and_dir)
	}
	ds_list_destroy(neighbour_list)
}

function get_neighbouring_obstructions(flock_agent, context_list)
{
	var neighbour_list = ds_list_create()
	collision_circle_list(flock_agent.x, flock_agent.y, flock_agent.flock_agent_neighbour_radius, p_obstruction, false, true, neighbour_list, false);
	for(var i = 0; i<ds_list_size(neighbour_list);i++)
	{
		var neighbour = neighbour_list[|i]
		var pos = [neighbour.x + neighbour.sprite_width/2, neighbour.y + neighbour.sprite_height/2, 0,0]
		ds_list_add(context_list,pos)
	}
	ds_list_destroy(neighbour_list)

}


function calculate_move_cohesion(flock_agent, context){

	if(ds_list_size(context) <= 0)
	{
		return [0,0]
	}
	var running_x = 0
	var running_y = 0
	var count = ds_list_size(context)
	for(var i = 0; i<ds_list_size(context);i++){
		var context_pos = context[|i]
		var context_pos_weight = context[|i][3]
		running_x += context_pos[0] * context_pos_weight
		running_y += context_pos[1] * context_pos_weight
	}
	running_x /= count
	running_y /=count
	
	var rel_x = running_x - flock_agent.x
	var rel_y = running_y - flock_agent.y
	return [rel_x, rel_y]
}
	
function calculate_move_steered_cohesion(flock_agent, context){

	if(ds_list_size(context) <= 0)
	{
		return [0,0]
	}
	var running_x = 0
	var running_y = 0
	var count = ds_list_size(context)
	for(var i = 0; i<ds_list_size(context);i++){
		var context_pos = context[|i]
		var context_pos_weight = context[|i][3]
		running_x += context_pos[0] * context_pos_weight
		running_y += context_pos[1] * context_pos_weight
	}
	running_x /= count
	running_y /=count
	
	var rel_x = running_x - flock_agent.x
	var rel_y = running_y - flock_agent.y
	//[rel_x, rel_y] needs to be smoothed out
	var spring_constant = 10
	var delta_t = 1/game_get_speed(gamespeed_fps)
	var current_dir = flock_agent.direction
	var current = [lengthdir_x(1, current_dir),lengthdir_y(1, current_dir)]
	var target = [rel_x, rel_y]
	
	var result = smooth_damp_flocking(current, target, current,delta_t, spring_constant)
	
	return result
}	
	
function calculate_move_alignment(flock_agent, context){
	if(ds_list_size(context) <= 0)
	{
		return [lengthdir_x(1,direction),lengthdir_y(1,direction)]
	}
	var running_x = 0
	var running_y = 0
	var count = ds_list_size(context)
	for(var i = 0; i<ds_list_size(context);i++){
		var context_direction = context[|i][2]
		var context_direction_weight = context[|i][3] 
		running_x += lengthdir_x(1, context_direction)*context_direction_weight
		running_y += lengthdir_x(1, context_direction)*context_direction_weight
	}
	running_x /= count
	running_y /=count
	
	return [running_x, running_y]
}

function calculate_move_avoidance(flock_agent, context)
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
		if( point_distance(flock_agent.x, flock_agent.y, context_pos[0], context_pos[1]) < flock_agent.flock_agent_neighbour_radius*flock_agent.flock_agent_avoidance_factor)
		{
			running_x += (flock_agent.x -context_pos[0] )
			running_y += (flock_agent.y -context_pos[1])
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


function calculate_move_stay_in_radius(flock_agent, context, center, radius, deadzone)
{
	var dist_to_center = point_distance(flock_agent.x, flock_agent.y, center.x, center.y)
	var center_offset_x  = center.x - flock_agent.x
	var center_offset_y = center.y - flock_agent.y
	var t = dist_to_center /radius
	
	if(t<deadzone){
		return [0,0]
	}
	return [center_offset_x*t*t, center_offset_y*t*t]

}