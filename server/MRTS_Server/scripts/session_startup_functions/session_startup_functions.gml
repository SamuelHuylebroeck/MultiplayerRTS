function receive_session_start(buffer){
	//reset the wait arrays
	ds_list_clear(ready_list)
	//Send the load signal to connected players
	broadcast_session_load()
	
}


function set_up_player(player, spawn_x, spawn_y){
	player.x = spawn_x
	player.y = spawn_y
	
	var step = 10
	for(var i =0; i< 3; i++)
	{
		var hornet = instance_create_layer(spawn_x+i*step, spawn_y+i*step, "Units", un_hornet)
		hornet.unit_controller = player.socket
		ds_list_add(player.unit_list, hornet)
		broadcast_create_unit(hornet)
	}
}

function start_multiplayer_session(){
	var start_pos_x = 200
	var start_pos_y = 200
	var step = 200
	//Load in units
	for(var i = 0; i< ds_list_size(socket_list); i++)
	{
		var socket = socket_list[|i]
		var player = ds_map_find_value(socket_to_player, socket)
		set_up_player(player, start_pos_x + i*step,start_pos_y + i*step)
	
	}
	//start session
	broadcast_session_start()
}



function receive_session_load(buffer, socket){
	var index = ds_list_find_index(ready_list, socket)
	if(index == -1){
		ds_list_add(ready_list, socket)
		if ds_list_size(ready_list) == ds_list_size(socket_list)
		{
			start_multiplayer_session()
		}
	
	}

}





function send_session_load(socket){
	buffer_seek(server_buffer, buffer_seek_start,0)
	buffer_write(server_buffer, buffer_u8, network.session_load)
	network_send_packet(socket, server_buffer, buffer_tell(server_buffer));

}

function broadcast_session_load(){
	for (var i =0; i< ds_list_size(socket_list); i++){
		var socket = ds_list_find_value(socket_list, i)
		send_session_load(socket)
	}
}

function send_session_start(socket){
	buffer_seek(server_buffer, buffer_seek_start,0)
	buffer_write(server_buffer, buffer_u8, network.session_start)
	network_send_packet(socket, server_buffer, buffer_tell(server_buffer));

}

function broadcast_session_start(){
	for (var i =0; i< ds_list_size(socket_list); i++){
		var socket = ds_list_find_value(socket_list, i)
		send_session_start(socket)
	}
}