#region configuration
#endregion

#region globals initialization
global.game_paused = false;
#endregion

#region enums
enum network
{
	player_establish,
	player_connect,
	player_joined,
	player_disconnect,
	player_sync,
	unit_create,
	move_order,
	test
}

enum unit_states{
	IDLE,
	MOVE
}
#endregion

#region player_colours
global.player_colours[0]= make_color_rgb(180,32,42)
global.player_colours[1] = make_color_rgb(36,159,222)
global.player_colours[2] = make_color_rgb(89,193,53)
global.player_colours[3] = make_color_rgb(255,213,65)
#endregion


