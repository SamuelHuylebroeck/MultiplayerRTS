function connect_to_server(){
	client = network_create_socket(network_socket_tcp)
	show_debug_message("Connecting to " + string(ip_address) + " at port " + string(port) + " with socket " + string(client)) 
	connected = network_connect(client, ip_address,port)
	show_debug_message("connection result " + string(connected))
	client_buffer = buffer_create(buffer_size, buffer_fixed, 1)
	socket_to_instanceid = ds_map_create();
}