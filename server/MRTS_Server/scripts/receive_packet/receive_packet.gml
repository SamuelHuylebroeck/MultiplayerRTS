function receive_packet(buffer, socket){
	var msg_id = buffer_read(buffer, buffer_u8)
	switch(msg_id){
		case network.player_establish:
			receive_establish(buffer, socket)
			//network_player_setup(socket, username)
			break;
		case network.session_start:
			receive_session_start(buffer)
			break;
		case network.session_load:
			receive_session_load(buffer, socket)
			break;
		case network.move_order:
			receive_mo_packet(buffer)
			break;
		case network.test:
			var msg_string = buffer_read(buffer, buffer_string);
			show_debug_message(string(msg_string));
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.test);
			network_send_packet(socket, server_buffer, buffer_tell(server_buffer))
		default:
			break;
	}
}

function receive_establish(buffer, socket){
	var player = ds_map_find_value(socket_to_player, socket)
	broadcast_player_sync(player)
}

function send_player_sync(socket, player){
	buffer_seek(server_buffer, buffer_seek_start,0)
	buffer_write(server_buffer, buffer_u8, network.player_sync)
	buffer_write(server_buffer, buffer_u8, player.socket);
	buffer_write(server_buffer, buffer_string, player.username);
	buffer_write(server_buffer, buffer_u32, player.assigned_colour);
	network_send_packet(socket, server_buffer, buffer_tell(server_buffer));

}
function broadcast_player_sync(player){
	for (var i =0; i< ds_list_size(socket_list); i++){
		var socket = ds_list_find_value(socket_list, i)
		send_player_sync(socket, player)
	}
}