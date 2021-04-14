var player_colour = c_white
if (!is_undefined(controlling_player) or controlling_player != -1){
	player_colour = controlling_player.assigned_colour
	if(global.debug_units_swarm){
		//player_colour = unit_override_colour
	}
}

shader_set(sha_team_colour)
shader_set_uniform_f(us_mark_colour, 1,1,1)
//Shader expects percentual colour values 
var colour_max_range = 255
shader_set_uniform_f(us_player_colour, colour_get_red(player_colour)/colour_max_range ,  colour_get_green(player_colour)/colour_max_range,  colour_get_blue(player_colour)/colour_max_range )

draw_sprite_ext(
	sprite_index,
	image_index,
	x,
	y,
	image_xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
)

if(shader_current() != -1) 
{
	shader_reset()
}
if(selected){
	draw_sprite_ext(spr_unit_selection_circle_small,0,x,y,1,1,0,c_white,0.7)
}

#region debug_draws
if (global.debug_units_all_pathfinding or (global.debug_units_selected_units_pathfinding and selected))
{
	draw_path_movement()
}
#endregion