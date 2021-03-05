#region configuration
unit_state_script[unit_states.IDLE] = -1
unit_state_script[unit_states.MOVE] = unit_movement

unit_state_sprite[unit_states.IDLE] = un_hornet
unit_state_sprite[unit_states.MOVE] = un_hornet
#endregion

#region declaration
target = noone
state = unit_states.IDLE
state_initialized = false
current_speed = 0
selected = false
current_order = noone
controlling_player = -1
#endregion

#region internal setup

#endregion