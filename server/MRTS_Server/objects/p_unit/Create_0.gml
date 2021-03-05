#region configuration
unit_state_script[unit_states.IDLE] = -1
unit_state_script[unit_states.MOVE] = unit_movement_server

unit_state_sprite[unit_states.IDLE] = un_hornet
unit_state_sprite[unit_states.MOVE] = un_hornet
#endregion

#region declaration
target = noone
state = unit_states.IDLE
state_initialized = false
current_speed = 0
current_order = noone
#endregion

#region internal setup

#endregion