// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function start_singleplayer_sandbox(){
	var local_game = instance_create_layer(0,0,"Logic",obj_local_game) 
	var local_player =instance_create_layer(0,0,"Logic",obj_local_player)
	local_player.username = "Local"
	local_player.assigned_colour=c_green
	local_player.state = player_states.FREE
	obj_local_game.local_player = local_player
	room_goto(room_multiplayer_sandbox)
}