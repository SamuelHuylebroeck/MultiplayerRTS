function smooth_damp_flocking(current, target,current_velocity, delta_t,spring_constant){

	var to_x = critically_damped_spring(current[0], target[0],current_velocity[0], delta_t, spring_constant )
	var to_y = critically_damped_spring(current[1], target[1],current_velocity[1], delta_t, spring_constant )
	
	return [to_x, to_y]
} 


function critically_damped_spring(current,target,current_velocity, delta_t, spring_constant)
{
	var distance = target - current
	var spring_force = distance * spring_constant
	var damping_force = -current_velocity * 2 * sqrt( spring_constant );
	
	var force = spring_force+damping_force
	current_velocity += force*delta_t
	var displacement =current_velocity*delta_t
	
	return current+displacement 
}