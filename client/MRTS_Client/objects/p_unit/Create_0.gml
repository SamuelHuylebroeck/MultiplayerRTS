#region configuration
unit_state_script[unit_states.IDLE] = unit_idle
unit_state_script[unit_states.GUARD] = unit_guard
unit_state_script[unit_states.MOVE] = unit_swarm_movement
unit_state_script[unit_states.CHASE] = unit_chase
unit_state_script[unit_states.ATTACK] = unit_attack
unit_state_script[unit_states.ATTACK_MOVE] = unit_attack_movement

unit_state_sprite[unit_states.IDLE] = spr_hornet_idle
unit_state_sprite[unit_states.MOVE] = spr_hornet_idle
unit_state_sprite[unit_states.GUARD] = spr_hornet_idle
unit_state_sprite[unit_states.CHASE] = spr_hornet_idle
unit_state_sprite[unit_states.ATTACK] = spr_hornet_idle
unit_state_sprite[unit_states.ATTACK_MOVE] = spr_hornet_idle


frames_per_displacement = 5
aggro_check_interval = 20
#endregion

#region declaration
target = noone
state = unit_default_state
state_initialized = false
current_speed = 0
selected = false
current_order = noone
controlling_player = -1
swarm = noone

//Shaders
us_mark_colour = shader_get_uniform(sha_team_colour, "marker_colour")
us_player_colour = shader_get_uniform(sha_team_colour, "player_colour")

//movement
collision_map = layer_tilemap_get_id(layer_get_id("Tiles_Collision"))
h_speed = 0
v_speed = 0 
current_path = path_add()
frames_to_displacement=0
unit_turn_rate_gs = unit_turn_rate / game_get_speed(gamespeed_fps)

aggro_counter = 0;
aggro_context = ds_list_create()
deaggro_counter = 0;

attack_on_cooldown = false

unit_current_hp = unit_max_hp

//order memory
ds_order_memory_stack = ds_stack_create()
//context memory
ds_unit_context = ds_list_create()

#endregion

#region internal setup

#endregion