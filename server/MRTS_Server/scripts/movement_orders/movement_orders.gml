//Create movement order
function create_movement_order(to_x, to_y, ds_unit_ids){
	if (ds_list_size(ds_unit_ids) > 0)
	{
		//Create on the server side
		var move_order = instance_create_layer(to_x,  to_y,"Orders", ord_move)
	
		for(var i=0; i<ds_list_size(ds_unit_ids); i++){
			var unit = ds_unit_ids[|i]
			with(unit){
				clear_current_order()
				current_order = move_order
				target = move_order
				state = unit_states.MOVE
				ds_list_add(move_order.ds_ordered_units, self.id)
			}
		}
		//Broadcast it to all connected clients
		broadcast_movement_order(to_x, to_y, ds_unit_ids)
	}

}
//Send movement order
function send_movement_order(socket, to_x, to_y, ds_unit_ids){
	buffer_seek(server_buffer, buffer_seek_start,0)
	buffer_write(server_buffer, buffer_u8, network.move_order)
	buffer_write(server_buffer, buffer_u16, to_x);
	buffer_write(server_buffer, buffer_u16, to_y);
	var nr_units = ds_list_size(ds_unit_ids)
	buffer_write(server_buffer, buffer_u16, nr_units);
	for (var i=0; i< ds_list_size(ds_unit_ids);i++){
		var unit_id = ds_unit_ids[|i]
		buffer_write(server_buffer, buffer_u32, unit_id);
	}
	network_send_packet(socket, server_buffer, buffer_tell(server_buffer));
}

//Broadcast movement order
function broadcast_movement_order(to_x, to_y, ds_unit_ids){
	//Iterate over sockets
	with(con_server){
		for (var i=0; i< ds_list_size(socket_list);i++){
			var socket = socket_list[|i]
			send_movement_order(socket, to_x, to_y, ds_unit_ids)
		}
	}

}

