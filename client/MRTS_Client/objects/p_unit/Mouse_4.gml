//Select this unit
var this_unit = self
var local_player = noone

if(global.connected)
{
	local_player = con_client.local_player
}else
{
	local_player = obj_local_game.local_player
}
with(local_player){
	clear_selection()
	if(this_unit.controlling_player = local_player)
	{
		add_unit_to_selection(this_unit)
	}
}

