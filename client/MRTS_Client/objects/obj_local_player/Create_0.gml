event_inherited()

#region configuration
order_default_state = order_states.MOVE


#endregion

#region declarations
selected_units = ds_list_create()
state = player_states.FREE
order_state = order_default_state

zoom_level = 1;
//Get the starting view size to be used for interpolation later
default_zoom_width = camera_get_view_width(view_camera[0]);
default_zoom_height = camera_get_view_height(view_camera[0]);



#endregion