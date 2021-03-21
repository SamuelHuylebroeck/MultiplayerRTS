#region declaration
ds_flock_agents = ds_list_create()
active = false
radius = 1024
deadzone = 0.5


#endregion

alarm[0] = 2*game_get_speed(gamespeed_fps)