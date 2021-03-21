// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_connection(){
	show_debug_message("Connecting to server")
	connection = instance_create_layer(0,0,"Logic",con_client)
	global.connected = true
}