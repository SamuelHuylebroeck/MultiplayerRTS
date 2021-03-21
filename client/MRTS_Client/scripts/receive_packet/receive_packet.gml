// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function receive_packet(buffer){
	var msg_id = buffer_read(buffer,buffer_u8)
	
	switch(msg_id)
	 {
		case network.player_establish:
			var recv_socket = buffer_read(buffer, buffer_u8)
			var recv_username = buffer_read(buffer, buffer_string)
			var recv_colour = buffer_read(buffer, buffer_u32)
			
			
			//create a local player
			local_player =instance_create_layer(0,0,"Logic",obj_local_player)
			local_player.username = recv_username
			local_player.assigned_colour=recv_colour
			local_player.socket = recv_socket
			local_player.state = player_states.MENU
			ds_map_add(socket_to_player_obj, local_player.socket, local_player)
			
			//Send setup details to server
			buffer_seek(con_client.client_buffer, buffer_seek_start, 0);
			buffer_write(con_client.client_buffer, buffer_u8, network.player_establish);
			network_send_packet(con_client.client, con_client.client_buffer, buffer_tell(con_client.client_buffer));
			break; 
		
		case network.player_connect:
			break;
			
		case network.player_joined:
			var socket = buffer_read(buffer, buffer_u8)
			var username = buffer_read(buffer, buffer_string)
			var assigned_colour = buffer_read(buffer, buffer_u32)
			var player_obj = instance_create_layer(0,0,"Logic", obj_remote_player)
			player_obj.socket = socket
			player_obj.username = username
			player_obj.assigned_colour = assigned_colour
			ds_map_add(socket_to_player_obj, socket, player_obj)
			break;
		
		case network.player_sync:
			receive_player_sync_packet(buffer)
			break;
		
		case network.player_disconnect:
			var recv_socket = buffer_read(buffer, buffer_u8)
			
			var player = ds_map_find_value(socket_to_instanceid, recv_socket)
			ds_map_delete(socket_to_instanceid, recv_socket)
			with(player)
			{
				instance_destroy()
			}
			break;
		
		case network.session_load:
			receive_session_load_packet(buffer)
			break;
		case network.session_start:
			receive_session_start_packet(buffer)
			break;
		case network.unit_create:
			receive_unit_creation_packet(buffer)
			break;
		case network.move_order:
			receive_mo_packet(buffer)
			break;
		
		default:
			break;
	 
	 }

}