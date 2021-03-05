function receive_packet(buffer, socket){
	var msg_id = buffer_read(buffer, buffer_u8)
	switch(msg_id){
		case network.player_establish:
			var username = buffer_read(buffer, buffer_string)
			network_player_setup(socket, username)
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