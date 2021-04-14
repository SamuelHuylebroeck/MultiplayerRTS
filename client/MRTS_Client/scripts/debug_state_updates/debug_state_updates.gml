function toggle_debug(){
	global.debug_units_state = !global.debug_units_state;
	global.debug_units_aggro = !global.debug_units_aggro;
	global.debug_selected_only = !global.debug_selected_only;
	global.debug_units_selected_units_pathfinding = !global.debug_units_selected_units_pathfinding;
	global.debug_units_all_pathfinding = !global.debug_units_all_pathfinding;
	global.debug_units_swarm = !global.debug_units_swarm;
	global.debug_units_movement_context = !global.debug_units_movement_context;
	global.debug_units_swarm_movement_contributions = !global.debug_units_swarm_movement_contributions;

}


function disable_all_debug(){
	global.debug_units_state = false;
	global.debug_units_aggro = false;
	global.debug_selected_only = false;
	global.debug_units_selected_units_pathfinding = false;
	global.debug_units_all_pathfinding = false;
	global.debug_units_swarm = false;
	global.debug_units_movement_context = false;
	global.debug_units_swarm_movement_contributions = false;
}