#region gathering the metrics
var nr_of_active_connections = ds_list_size(con_server_obj.socket_list)
var max_nr_connections = con_server_obj.max_clients
#endregion

var current_x_offset = initial_x_offset
var current_y_offset = initial_y_offset

#region drawing the metrics
#region connection config
draw_text(current_x_offset,current_y_offset, "Open port: " + string(con_server_obj.port))
current_y_offset +=15;
draw_text(current_x_offset,current_y_offset, "Buffer size: " + string(con_server_obj.buffer_size))
#endregion

#region connection metrics
current_y_offset +=20;
draw_text(current_x_offset,current_y_offset, "Active connections: " + string(nr_of_active_connections)+"/"+string(max_nr_connections))
#endregion
#endregion