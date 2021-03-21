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