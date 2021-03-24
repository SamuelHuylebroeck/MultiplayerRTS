if(global.debug_units_swarm and swarm_active){
	var old_color = draw_get_color()
	var old_alpha = draw_get_alpha()
	
	
	draw_set_color(c_blue)
	draw_set_alpha(0.05)
	draw_circle(x,y, swarm_radius,false)
	
	draw_set_color(c_navy)
	draw_set_alpha(0.05)
	draw_circle(x,y, swarm_radius*swarm_deadzone,false)

	draw_set_color(old_color)
	draw_set_alpha(old_alpha)
}