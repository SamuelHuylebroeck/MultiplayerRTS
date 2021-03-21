function draw_player_vis(pos_x, pos_y, player)
{
	var old_color = draw_get_color()
	var old_halign = draw_get_halign()
	var old_valign = draw_get_valign()
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_middle)
	
	draw_set_color(player.assigned_colour)
	draw_circle(pos_x, pos_y,10, false)
	draw_set_color(c_white)
	draw_text(pos_x+10,pos_y, player.username)
	
	draw_set_color(old_color)
	draw_set_halign(old_halign)
	draw_set_valign(old_valign)

}