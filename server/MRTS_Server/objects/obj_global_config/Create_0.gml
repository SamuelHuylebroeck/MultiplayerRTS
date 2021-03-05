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
	unit_create,
	move_order,
	test
}

enum unit_states{
	IDLE,
	MOVE
}

#endregion

