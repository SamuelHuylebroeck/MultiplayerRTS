function unit_guard(){
	//Decay unit speed
	current_speed = clamp(current_speed-unit_acceleration, 0 , unit_max_speed)
	//Get pushed around by others units and unstuck out of possible impassible terrain
	frames_to_displacement--;
	if(frames_to_displacement<=0){
		displace_self();
		frames_to_displacement = frames_per_displacement
	}
	//Check for aggro
	var target_found = check_for_aggro()
	//If a target is found, switch to chase
	if(target_found) 
	{
		var guard_context = {
			context_state: state,
			g_x: x,
			g_y: y
		};
		ds_stack_push(ds_order_memory_stack, guard_context)
		
		initialize_chase()
	}
	

}

function initialize_guard()
{
	state = unit_states.GUARD
	sprite_index = unit_state_sprite[state]

}