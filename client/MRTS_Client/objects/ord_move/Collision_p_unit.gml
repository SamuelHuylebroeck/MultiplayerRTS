var index = ds_list_find_index(ds_ordered_units, other.id)
var unit = other
if(index != -1)
{
	//show_debug_message("MO: Collision with " + string(other.id))
	//Update unit
	with(unit)
	{
		state = unit_default_state
		switch(state){
			case unit_states.IDLE:
				initialize_idle()
				break;
			case unit_states.GUARD:
				initialize_guard()
				break;
			default:
				break;
		
		}
		state_initialized=false
		current_speed = 0
		target = noone
		path_clear_points(current_path)
	}
	//remove from swarm
	if(swarm !=-1)
	{
		with(swarm)
		{
			var swarm_index = ds_list_find_index(ds_swarm_agents, unit.id)
			if (swarm_index != -1){
				ds_list_delete(ds_swarm_agents, swarm_index)
					if(ds_list_size(ds_swarm_agents) <= 0){
						instance_destroy()
					}	
			}
		}
	
	}
	//remove from list
	//show_debug_message("Removing " + string(other.id)+" from the ordered unit list")
	ds_list_delete(ds_ordered_units, index)
	//Check if list is empty to see if this object can be removed
	if(ds_list_size(ds_ordered_units) <= 0){
		instance_destroy()
	}	
}


