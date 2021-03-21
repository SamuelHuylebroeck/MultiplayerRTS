function receive_session_load_packet(buffer){
	room_goto(room_multiplayer_sandbox);
	session_state = session_states.INGAME;
}

function send_session_load_packet(){
	buffer_seek(con_client.client_buffer, buffer_seek_start, 0);
	buffer_write(con_client.client_buffer, buffer_u8, network.session_load);
	network_send_packet(con_client.client, con_client.client_buffer, buffer_tell(con_client.client_buffer));
}

function receive_session_start_packet(buffer)
{
	local_player.state = player_states.FREE

}