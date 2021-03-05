// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function receive_packet(buffer){
	var msg_id = buffer_read(buffer,buffer_u8)
	
	switch(msg_id)
	 {
		case network.player_establish:
			var recv_socket = buffer_read(buffer, buffer_u8)
			obj_local_player.socket_id = recv_socket
			//Send setup details to server
			var username = obj_local_player.player_username
			buffer_seek(con_client.client_buffer, buffer_seek_start, 0);
			buffer_write(con_client.client_buffer, buffer_u8, network.player_establish);
			buffer_write(con_client.client_buffer, buffer_string,username);
			network_send_packet(con_client.client, con_client.client_buffer, buffer_tell(con_client.client_buffer));
			break; 
		
		case network.player_connect:
			var recv_socket = buffer_read(buffer, buffer_u8)
			var spawn_x = buffer_read(buffer, buffer_u16)
			var spawn_y = buffer_read(buffer, buffer_u16)
			//var player = instance_create_layer(spawn_x, spawn_y, "Instances", obj_player)
			//ds_map_add(socket_to_instanceid, recv_socket, player)
			break;
			
		case network.player_joined:
			var recv_socket = buffer_read(buffer, buffer_u8)
			var spawn_x = buffer_read(buffer, buffer_u16)
			var spawn_y = buffer_read(buffer, buffer_u16)
			//var follower = instance_create_layer(spawn_x, spawn_y, "Instances", obj_follower)
			//ds_map_add(socket_to_instanceid, recv_socket, follower)
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
		
		case network.test:
			with(obj_connection_status){
				image_index = 1
			}
			break;
			
		case network.unit_create:
			var type_string = buffer_read(buffer, buffer_string)
			var id_on_server = buffer_read(buffer, buffer_u32)
			var controller_id = buffer_read(buffer, buffer_u16)
			var spawn_x = buffer_read(buffer, buffer_u16)
			var spawn_y = buffer_read(buffer, buffer_u16)
			
			
			var type = get_unit_type(type_string)
			var unit = instance_create_layer(spawn_x, spawn_y,"Instances", type)
			unit.controlling_player = controller_id
			unit.server_id = id_on_server
			ds_map_add(obj_multiplayer_game.map_unit_server_to_local, unit.server_id, unit.id)
			break;
		case network.move_order:
			receive_mo_packet(buffer)
			break;
		
		default:
			break;
	 
	 }

}