function receive_mo_packet(buffer){
	var move_x = buffer_read(buffer, buffer_u16)
	var move_y = buffer_read(buffer, buffer_u16)
	
	var nr_units = buffer_read(buffer, buffer_u16)
	var ds_units_to_order = ds_list_create()
	
	//Get all ordered units
	for(var i=0; i<nr_units;i++){
		var server_unit_id = buffer_read(buffer, buffer_u32)
		ds_list_add(ds_units_to_order, server_unit_id)
	}
	
	create_movement_order(move_x, move_y, ds_units_to_order)
	ds_list_destroy(ds_units_to_order)

}