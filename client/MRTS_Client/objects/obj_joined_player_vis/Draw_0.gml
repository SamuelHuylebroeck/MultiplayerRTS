//Get the list of joined players
var players = ds_map_values_to_array(con_client.socket_to_player_obj)
var nr_players = array_length(players)


var step = 20

for(var i=0;i<nr_players;i++){
	var player_to_draw = players[i]
	draw_player_vis(x,y+i*step, player_to_draw)
	

}

