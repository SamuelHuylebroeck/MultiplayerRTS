function receive_unit_creation_packet(buffer){
	var type_string = buffer_read(buffer, buffer_string)
	var id_on_server = buffer_read(buffer, buffer_u32)
	var controller_id = buffer_read(buffer, buffer_u16)
	var spawn_x = buffer_read(buffer, buffer_u16)
	var spawn_y = buffer_read(buffer, buffer_u16)
			
			
	var type = get_unit_type(type_string)
	var unit = instance_create_layer(spawn_x, spawn_y,"Instances", type)
	var controlling_player = ds_map_find_value(socket_to_player_obj, controller_id)
	unit.controlling_player = controlling_player
	unit.server_id = id_on_server
	var current_keys = ds_map_keys_to_array(current_game.map_unit_server_to_local)
	ds_map_add(current_game.map_unit_server_to_local, unit.server_id, unit.id)
}