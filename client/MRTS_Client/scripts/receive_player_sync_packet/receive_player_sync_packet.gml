function receive_player_sync_packet(buffer){
	//Read in socket
	var socket = buffer_read(buffer, buffer_u8)
	var username = buffer_read(buffer, buffer_string)
	var assigned_colour = buffer_read(buffer, buffer_u32)
	
	handle_player_sync(socket, username, assigned_colour)


}

function handle_player_sync(socket, username, assigned_colour){
	//Check if a player object already exists in the session
	var player_obj = ds_map_find_value(socket_to_player_obj, socket)
	//Create one if necessary, won't ever happen for a local player
	if is_undefined(player_obj)
	{
		player_obj = instance_create_layer(0,0,"Logic", obj_remote_player)
		player_obj.socket = socket
		ds_map_add(socket_to_player_obj, socket, player_obj)
	}
	player_obj.username = username
	player_obj.assigned_colour = assigned_colour
}
