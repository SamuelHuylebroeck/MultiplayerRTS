#region configuration
ip_address = "127.0.0.1"
port = 8421
buffer_size = 2048
#endregion

#region declarations
socket_to_player_obj = ds_map_create();
local_player = noone
current_game = noone
session_state = session_states.LOBBY
#endregion
connect_to_server()