// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function unit_movement(){
	
	if (not state_initialized)
	{
		init_movement();
	}
	current_speed = clamp(current_speed + unit_acceleration, 0, unit_max_speed)
	path_speed = current_speed
	animate_movement();
	//displace_colliding_units();
}


function unit_swarm_movement(){
	current_speed = clamp(current_speed + unit_acceleration, 0, unit_max_speed)
	
	
	//Calculate direction
	if(ds_queue_size(ds_position_history)>5){
		var pos = ds_queue_dequeue(ds_position_history) 
		direction = point_direction(pos[0], pos[1],x,y)
	}

	ds_queue_enqueue(ds_position_history, [x,y])
	image_angle=direction
	
}


function init_movement(){
	if (not state_initialized and target != noone){
		path_found = calculate_movement_path(target.x,target.y, current_path)
		if (path_found){
			path_start(current_path,current_speed, path_action_stop, false)
		}
		state_initialized = true
	}
}

function animate_movement(){
		image_angle = direction
}

function displace_colliding_units(){
	var displacement_value = 4
	var ds_units_colliding = ds_list_create()
	var nr_collisions = instance_place_list(x,y, p_unit, ds_units_colliding, false)
	if (nr_collisions > 0)
	{
		for (var i = 0; i< ds_list_size(ds_units_colliding); i++)
		{
			var colliding_unit = ds_units_colliding[|i]
			
			with(colliding_unit)
			{
				if(state != unit_states.MOVE)
				{
					var old_direction = direction
					var displacement_direction = point_direction(other.x, other.y, x,y)
					var displacement_x = lengthdir_x(displacement_value, displacement_direction)
					var displacement_y = lengthdir_y(displacement_value, displacement_direction)
					x += displacement_x
					y += displacement_y
					direction = old_direction
				}
			
			}
		}
	
	}
	
	ds_list_destroy(ds_units_colliding)


}