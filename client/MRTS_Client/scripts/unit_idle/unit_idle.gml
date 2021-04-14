function unit_idle(){
	//Decay unit speed
	current_speed = clamp(current_speed-unit_acceleration, 0 , unit_max_speed)
	//Displace colliding units
	//displace_colliding_units();
	//Get pushed around by others units and unstuck out of possible impassible terrain
	frames_to_displacement--;
	if(frames_to_displacement<=0){
		displace_self();
		frames_to_displacement = frames_per_displacement
	}
	
}

function initialize_idle()
{
	state = unit_states.IDLE
	sprite_index = unit_state_sprite[state]

}

function displace_self(){
	var displacement_value = 4
	var ds_obstructions_colliding = ds_list_create()
	var nr_collisions = instance_place_list(x,y, p_unit, ds_obstructions_colliding, true)
	if (nr_collisions > 0)
	{
		var closest_obstruction = ds_obstructions_colliding[|0];
		//get the middle of the obstruction
		var middle_x = closest_obstruction.x + closest_obstruction.sprite_width/2
		var middle_y = closest_obstruction.y + closest_obstruction.sprite_height/2
		
		var dir = point_direction(middle_x, middle_y, x,y)
		
		var displace_x = lengthdir_x(displacement_value, dir)
		var displace_y = lengthdir_y(displacement_value, dir)
		scr_unit_execute_movement_and_collision(displace_x, displace_y)
		//x+=displace_x
		//y+=displace_y
	}
	ds_list_destroy(ds_obstructions_colliding)

}
	
	