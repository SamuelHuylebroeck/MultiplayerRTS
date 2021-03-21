#region configuration
#macro COLLISION_TILESIZE 32
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
	session_start,
	session_load,
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
	SELECTING,
	MENU
}

enum session_states{
	LOBBY,
	INGAME

}

#endregion

#region debug visualization settings
global.debug_units_state = false;
global.debug_units_ownership = false;
global.debug_units_selected_units_pathfinding = true;
global.debug_units_all_pathfinding = false;
#endregion