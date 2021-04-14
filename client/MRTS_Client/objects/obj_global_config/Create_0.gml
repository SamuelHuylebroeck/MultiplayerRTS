#region configuration
#macro COLLISION_TILESIZE 32
global.sfx_gain_base = 1
global.sound_effect_scale = 1
global.sound_master_scale = 1
global.sfx_priority = 1
global.attack_aggro_cooldown = 15
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
	GUARD,
	MOVE,
	CHASE,
	ATTACK,
	ATTACK_MOVE
}

enum player_states{
	FREE,
	SELECTING,
	MENU
}

enum order_states{
	MOVE,
	ATTACK
}

enum session_states{
	LOBBY,
	INGAME

}

#endregion

#region debug visualization settings
global.debug_units_state = true;
global.debug_units_aggro = false;
global.debug_units_swarm_movement_context = true;
global.debug_units_swarm_movement_contributions = true;
global.debug_units_swarm_movement_contributions_scale = 10;
global.debug_selected_only = false;
global.debug_units_selected_units_pathfinding = true;
global.debug_units_all_pathfinding = false;
global.debug_units_swarm = true;
#endregion