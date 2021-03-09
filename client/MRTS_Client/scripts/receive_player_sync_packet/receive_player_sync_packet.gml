function receive_player_sync_packet(buffer){
	//Read in socket
	var socket = buffer_read(buffer, buffer_u8)
	var username = buffer_read(buffer, buffer_string)
	var assigned_colour = buffer_read(buffer, buffer_u32)
	
	if(obj_local_player.socket_id == socket){
		handle_local_player_sync(socket, username, assigned_colour)
	}else{
		handle_remote_player_sync(socket, username, assigned_colour)
	}

}

function handle_local_player_sync(socket, username, assigned_colour){
	obj_local_player.socket_id = socket
	obj_local_player.username = username
	obj_local_player.assigned_colour = assigned_colour
	
	
	var player_obj = ds_map_find_value(obj_multiplayer_game.map_socket_to_player_object, socket)
	if is_undefined(player_obj)
	{
		ds_map_add(obj_multiplayer_game.map_socket_to_player_object, obj_local_player.socket_id, obj_local_player)
	}
}

function handle_remote_player_sync(socket, username, assigned_colour){
	//Check if a player object already exists in the session
	var player_obj = ds_map_find_value(obj_multiplayer_game.map_socket_to_player_object, socket)
	//Create one if necessary
	if is_undefined(player_obj)
	{
		player_obj = instance_create_layer(0,0,"Logic", obj_remote_player)
		ds_map_add(obj_multiplayer_game.map_socket_to_player_object, socket, player_obj)
	}
	player_obj.username = username
	player_obj.assigned_colour = assigned_colour
	

}