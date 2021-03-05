var index = ds_list_find_index(ds_ordered_units, other.id)
show_debug_message("index " + string(index))
if(index != -1)
{
	show_debug_message("Collision with " + string(other.id))
	//Update unit
	with(other)
	{
		state = unit_states.IDLE
		state_initialized=false
		current_speed = 0
		target = noone
	}
	//remove from list
	show_debug_message("Removing " + string(other.id)+" from the ordered unit list")
	show_debug_message("List size: " + string(ds_list_size(ds_ordered_units)))
	ds_list_delete(ds_ordered_units, index)
	show_debug_message("List size: " + string(ds_list_size(ds_ordered_units)))
	//Check if list is empty to see if this object can be removed
	if(ds_list_size(ds_ordered_units) <= 0){
		instance_destroy()
	}	
}


