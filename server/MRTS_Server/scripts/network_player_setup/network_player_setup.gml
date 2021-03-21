function network_player_setup(socket, username){
	var step = 200
	var nr_active_players = ds_list_size(socket_list)
	var spawn_x = nr_active_players*step
	var spawn_y = nr_active_players*step
	
	var player = instance_create_layer(spawn_x, spawn_y, "Players", obj_player)
	player.username=username
	player.socket=socket
	player.assigned_colour = global.player_colours[nr_active_players-1]
	
	//Register player and bring  their local session up to date with the server state
	ds_map_add(socket_to_player, socket, player)
	broadcast_player_sync(player)
	load_in_players(socket)
	load_in_units(socket)
	
	//Spawn a single hornet
	var hornet = instance_create_layer(spawn_x, spawn_y, "Units", un_hornet)
	hornet.unit_controller = socket
	ds_list_add(player.unit_list, hornet)
	broadcast_create_unit(hornet)

}



function load_in_players(player_socket){
	for (var i=0; i<ds_list_size(socket_list); i++)
	{
		var other_socket = socket_list[|i]
		if player_socket != other_socket
		{
			var other_player = ds_map_find_value(socket_to_player, other_socket)
			send_player_sync(player_socket, other_player)
		}
	}

}

function load_in_units(player_socket){
	for (var i=0; i<ds_list_size(socket_list); i++)
	{
		var other_socket = socket_list[|i]
		if player_socket != other_socket
		{
			var other_player = ds_map_find_value(socket_to_player, other_socket)
			for (var j=0; j < ds_list_size(other_player.unit_list); j++){
				var unit = other_player.unit_list[|j]
				send_create_unit(player_socket, unit)			
			} 
		}
	}

}

