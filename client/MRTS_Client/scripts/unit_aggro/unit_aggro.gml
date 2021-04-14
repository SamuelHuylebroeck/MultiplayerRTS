function check_for_aggro(){
	var target_found = false
	//Check for aggro
	if (--aggro_counter<=0)
	{
		
		aggro_counter = aggro_check_interval;
		//build aggro context
		ds_list_clear(aggro_context)
		collision_circle_list(x, y, unit_aggro_radius, p_unit, false, true, aggro_context, false);
		//check if a target is present
		var distance_to_target = unit_aggro_radius * 2
		for(var i = 0; i <ds_list_size(aggro_context); i++)
		{
			var unit_to_consider = aggro_context[|i]
			if(unit_to_consider.controlling_player != controlling_player.id)
			{
				var distance_to_unit = point_distance(x,y,unit_to_consider.x, unit_to_consider.y)
				if (distance_to_unit < distance_to_target)
				{
					target  = unit_to_consider
					distance_to_target = distance_to_unit
					target_found = true
				}
			}
		}
	}
	return target_found

}

function check_for_deaggro(){
	//Check for aggro
	if (--deaggro_counter <= 0)
	{
		
		deaggro_counter = unit_aggro_duration * game_get_speed(gamespeed_fps);
		if(target != noone)
		{
			var distance_to_target = point_direction(x,y,target.x, target.y)
			if(distance_to_target > unit_aggro_radius)
			{
				target = noone
				return true
			}
		
		}
	}
	return false

}