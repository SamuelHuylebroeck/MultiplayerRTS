// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function start_multiplayer_session(){
	buffer_seek(con_client.client_buffer, buffer_seek_start, 0);
	buffer_write(con_client.client_buffer, buffer_u8, network.session_start);
	network_send_packet(con_client.client, con_client.client_buffer, buffer_tell(con_client.client_buffer));
	
	con_client.current_game = instance_create_layer(0,0,"Logic", obj_multiplayer_game)
		
}