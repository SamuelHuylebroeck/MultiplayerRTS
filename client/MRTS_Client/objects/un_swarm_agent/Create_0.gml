// Inherit the parent event
event_inherited();
unit_state_script[unit_states.IDLE] = unit_idle
unit_state_script[unit_states.MOVE] = unit_swarm_movement


ds_position_history = ds_queue_create()