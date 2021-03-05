function network_player_setup(socket, username){
	var step = 200
	var nr_active_players = ds_list_size(socket_list)
	var spawn_x = nr_active_players*step
	var spawn_y = nr_active_players*step
	
	var player = instance_create_layer(spawn_x, spawn_y, "Players", obj_player)
	player.username=username
	player.socket=socket
	
	//Register player and bring  their local session up to date with the server state
	ds_map_add(socket_to_player, socket, player)
	load_in_units(socket)
	
	//Spawn a single hornet
	var hornet = instance_create_layer(spawn_x, spawn_y, "Units", un_hornet)
	hornet.unit_controller = socket
	ds_list_add(player.unit_list, hornet)
	broadcast_create_unit(hornet)

}
function send_create_unit(socket, unit){
	buffer_seek(server_buffer, buffer_seek_start,0)
	buffer_write(server_buffer, buffer_u8, network.unit_create)
	buffer_write(server_buffer, buffer_string, unit.unit_type);
	buffer_write(server_buffer, buffer_u32, unit.id);
	buffer_write(server_buffer, buffer_u16, unit.unit_controller);
	buffer_write(server_buffer, buffer_u16, unit.x);
	buffer_write(server_buffer, buffer_u16, unit.y);
	network_send_packet(socket, server_buffer, buffer_tell(server_buffer));
}


function broadcast_create_unit(unit){
	for (var i =0; i< ds_list_size(socket_list); i++){
		var socket = ds_list_find_value(socket_list, i)
		send_create_unit(socket, unit)
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