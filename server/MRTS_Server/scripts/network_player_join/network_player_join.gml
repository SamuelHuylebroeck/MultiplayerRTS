function network_player_join(socket){
	ds_list_add(socket_list, socket);
	//Create the player object on the serverside
	var step = 200
	var nr_active_players = ds_list_size(socket_list)
	var spawn_x = nr_active_players*step
	var spawn_y = nr_active_players*step
	
	var player = instance_create_layer(spawn_x, spawn_y, "Players", obj_player)
	player.username=global.player_default_names[nr_active_players-1]
	player.socket=socket
	player.assigned_colour = global.player_colours[nr_active_players-1]
	
	ds_map_add(socket_to_player, socket, player)
	
	
	//Send the establish information to the player in question
	buffer_seek(server_buffer, buffer_seek_start,0)
	buffer_write(server_buffer, buffer_u8, network.player_establish)
	buffer_write(server_buffer, buffer_u8, socket);
	buffer_write(server_buffer, buffer_string, player.username);
	buffer_write(server_buffer, buffer_u32, player.assigned_colour);
	network_send_packet(socket, server_buffer, buffer_tell(server_buffer));
	//Inform all other players that a player is joining
	broadcast_others_player_join(player)
	//Inform the just joined players of everyone present
	send_existing_players(socket)
	
}

function send_player_join(to_socket, player){
	buffer_seek(server_buffer, buffer_seek_start,0)
	buffer_write(server_buffer, buffer_u8, network.player_joined)
	buffer_write(server_buffer, buffer_u8, player.socket);
	buffer_write(server_buffer, buffer_string, player.username);
	buffer_write(server_buffer, buffer_u32, player.assigned_colour);
	network_send_packet(to_socket, server_buffer, buffer_tell(server_buffer));

}

function broadcast_others_player_join(player)
{
	for (var i =0; i< ds_list_size(socket_list); i++){
		var socket = ds_list_find_value(socket_list, i)
		if (socket != player.socket)
		{
			send_player_join(socket, player)
		}
		
	}
}

function send_existing_players(socket){
	for (var i =0; i< ds_list_size(socket_list); i++){
		var other_socket = ds_list_find_value(socket_list, i)
		if(socket != other_socket)
		{
			var player = ds_map_find_value(socket_to_player, other_socket)
			send_player_join(socket, player)
		}

	}

}

