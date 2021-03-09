#region configuration

#endregion

#region globals initialization
global.game_paused = false;
global.connected = false;
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

enum player_states{
	FREE,
	SELECTING
}

#endregion

#region debug visualization settings
global.debug_units_state = false;
global.debug_units_ownership = false;
#endregion