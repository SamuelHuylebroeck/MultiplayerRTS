var nr_currently_selected_units = ds_list_size(selected_units)
if nr_currently_selected_units > 0 
{
	if global.connected 
	{
		send_movement_order(mouse_x, mouse_y, selected_units)
	}else
	{
		create_movement_order(mouse_x, mouse_y, selected_units)
	}
}