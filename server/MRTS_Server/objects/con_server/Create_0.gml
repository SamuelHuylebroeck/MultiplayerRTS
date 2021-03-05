#region server config
port = 8421;
max_clients = 4;
buffer_size = 2048;
#endregion

show_debug_message("Creating network server at port " + string(port))
network_create_server(network_socket_tcp, port, max_clients);
show_debug_message("Server created")

server_buffer = buffer_create(buffer_size, buffer_fixed, 1);

socket_list = ds_list_create();
socket_to_player = ds_map_create();
