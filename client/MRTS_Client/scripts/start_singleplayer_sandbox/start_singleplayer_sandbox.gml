// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function start_singleplayer_sandbox(){
	var local_game = instance_create_layer(0,0,"Logic",obj_local_game) 
	var local_player =instance_create_layer(0,0,"Logic",obj_local_player)
	local_player.username = "Local"
	local_player.assigned_colour=c_green
	local_player.state = player_states.FREE
	obj_local_game.local_player = local_player
	ds_map_add(obj_local_game.player_map, local_player.id, local_player)
	
	var enemy_player = instance_create_layer(0,0,"Logic", obj_remote_player)
	enemy_player.username= "Enemy_Inert"
	enemy_player.assigned_colour = c_red
	obj_local_game.enemy_player = enemy_player
	ds_map_add(obj_local_game.player_map, enemy_player.id, enemy_player)
	room_goto(room_multiplayer_sandbox)
}