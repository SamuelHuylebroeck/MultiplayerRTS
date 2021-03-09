var player_colour = c_white
if (controlling_player != -1 or !is_undefined(controlling_player)){
	var player_colour = controlling_player.assigned_colour
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