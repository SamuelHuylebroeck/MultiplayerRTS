function draw_path_movement(){
	var old_color = draw_get_color()
	
	if(path_get_number(current_path)>0)
	{
		draw_set_color(c_blue)
		draw_path(current_path,x,y,true)
	
	}
	
	draw_set_color(old_color)
}

function swarm_draw_radii(){
	var old_color=draw_get_alpha()
	var old_alpha=draw_get_alpha()
	
	//neighbour radius
	draw_set_color(c_lime)
	draw_set_alpha(0.2)
	draw_circle(x,y,swarm_agent_neighbour_radius,false)
	
	draw_set_color(c_green)
	draw_set_alpha(0.4)
	draw_circle(x,y,swarm_agent_neighbour_radius,true)
	
	//avoidance radius
	draw_set_color(c_red)
	draw_set_alpha(0.2)
	draw_circle(x,y,swarm_agent_neighbour_radius*swarm_agent_avoidance_factor,false)
	
	draw_set_alpha(0.4)
	draw_circle(x,y,swarm_agent_neighbour_radius*swarm_agent_avoidance_factor,true)
	
	
	//reset
	draw_set_color(old_color)
	draw_set_alpha(old_alpha)

}
	
function draw_direction_and_speed(){
	var old_color=draw_get_alpha()
	var old_alpha=draw_get_alpha()
	
	draw_set_color(c_red)
	
	var direction_scale = 32
	var direction_x = lengthdir_x(1,direction)*direction_scale + x
	var direction_y = lengthdir_y(1,direction)*direction_scale + y
	draw_arrow(x,y,direction_x,direction_y, 5 )
	
	draw_set_color(c_green)
	var speed_scale =100
	var speed_x = lengthdir_x(1,direction)*speed*speed_scale + x
	var speed_y = lengthdir_y(1,direction)*speed*speed_scale + y
	
	draw_arrow(x,y,speed_x, speed_y, 5)
	
	draw_set_color(old_color)
	draw_set_alpha(old_alpha)
}