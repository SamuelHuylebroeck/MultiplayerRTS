/// @description Issue attack order on this unit
var this_unit = self
if(global.connected)
{
	var local_player= con_client.local_player
	send_attack_order(local_player, this_unit, local_player.selected_units)
}else
{
	var local_player= obj_local_game.local_player
	create_attack_order(local_player, this_unit, local_player.selected_units)
}





