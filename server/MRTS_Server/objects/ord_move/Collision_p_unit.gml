var index = ds_list_find_index(ds_ordered_units, other.id)
show_debug_message("index " + string(index))
if(index != -1)
{
	//Update unit
	with(other)
	{
		state = unit_states.IDLE
		state_initialized=false
		current_speed = 0
		target = noone
	}
	//remove from list
	ds_list_delete(ds_ordered_units, index)
	//Check if list is empty to see if this object can be removed
	if(ds_list_size(ds_ordered_units) <= 0){
		instance_destroy()
	}	
}
