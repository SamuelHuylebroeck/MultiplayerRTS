type_event = ds_map_find_value(async_load, "type");


switch(type_event){
	
	case network_type_connect:
		var socket = ds_map_find_value(async_load, "socket")
		ds_list_add(socket_list, socket);
		buffer_seek(server_buffer, buffer_seek_start,0)
		buffer_write(server_buffer, buffer_u8, network.player_establish)
		buffer_write(server_buffer, buffer_u8, socket);
		network_send_packet(socket, server_buffer, buffer_tell(server_buffer));
		
		break;
	case network_type_disconnect:
		var socket = ds_map_find_value(async_load, "socket")
		ds_list_delete(socket_list, ds_list_find_index(socket_list, socket))
		var player = ds_map_find_value(socket_to_player, socket)
		ds_map_delete(socket_to_player, socket)
		with(player){
			instance_destroy()
		}
		for (var i =0; i< ds_list_size(socket_list); i++){
			var _other_sock = ds_list_find_value(socket_list, i)
			//send the location of the other player to this player
			var _follower = ds_map_find_value(socket_to_player, _other_sock)
			buffer_seek(server_buffer, buffer_seek_start,0)
			buffer_write(server_buffer, buffer_u8, network.player_disconnect)
			buffer_write(server_buffer, buffer_u8, socket);
			network_send_packet(_other_sock, server_buffer, buffer_tell(server_buffer));
		}
		
		break;
	case network_type_data:
		var buffer =  ds_map_find_value(async_load, "buffer");
		buffer_seek(buffer, buffer_seek_start,0);
		var socket = ds_map_find_value(async_load, "id");
		receive_packet(buffer, socket)
		break;

}