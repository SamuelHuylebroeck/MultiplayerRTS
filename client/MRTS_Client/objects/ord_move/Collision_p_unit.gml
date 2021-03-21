var index = ds_list_find_index(ds_ordered_units, other.id)
var unit = other
if(index != -1)
{
	//show_debug_message("MO: Collision with " + string(other.id))
	//Update unit
	with(unit)
	{
		state = unit_states.IDLE
		state_initialized=false
		current_speed = 0
		target = noone
		path_clear_points(current_path)
	}
	//remove from flock
	if(flock !=-1)
	{
		with(flock)
		{
			var flock_index = ds_list_find_index(ds_flock_agents, unit.id)
			if (flock_index != -1){
				ds_list_delete(ds_flock_agents, index)
					if(ds_list_size(ds_flock_agents) <= 0){
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


