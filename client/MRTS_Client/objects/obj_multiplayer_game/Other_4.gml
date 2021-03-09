event_inherited()
if (not global.connected){
	create_connection()
}
map_unit_server_to_local = ds_map_create()
map_socket_to_player_object = ds_map_create()