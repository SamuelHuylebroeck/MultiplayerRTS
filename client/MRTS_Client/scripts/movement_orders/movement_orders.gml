function create_movement_order(x,y,ds_units_to_order){
	var to_order = ds_list_create()
	ds_list_copy(to_order ,ds_units_to_order)
	//Create a move order object
	var mo = instance_create_layer(x, y, "Orders", ord_move)
	//Add the units to this move order
	for (var i = 0; i<ds_list_size(to_order); i++)
	{
		var unit = to_order[|i]
		ds_list_add(mo.ds_ordered_units, unit.id)
		with(unit){
			clear_current_order()
			current_order = mo
			target = mo
			state = unit_states.MOVE
		}
	}
	ds_list_destroy(to_order)
}


function send_movement_order(to_x, to_y, ds_units_to_order){
	with(con_client)
	{
		buffer_seek(client_buffer, buffer_seek_start,0)
		buffer_write(client_buffer, buffer_u8, network.move_order)
		buffer_write(client_buffer, buffer_u16, to_x);
		buffer_write(client_buffer, buffer_u16, to_y);
		var nr_units = ds_list_size(ds_units_to_order)
		buffer_write(client_buffer, buffer_u16, nr_units);
		for (var i=0; i< ds_list_size(ds_units_to_order);i++)
		{
			var unit_id = ds_units_to_order[|i]
			var unit_id_server = unit_id.server_id
			buffer_write(client_buffer, buffer_u32, unit_id_server);
		}
		network_send_packet(client, client_buffer, buffer_tell(client_buffer));
	}
}