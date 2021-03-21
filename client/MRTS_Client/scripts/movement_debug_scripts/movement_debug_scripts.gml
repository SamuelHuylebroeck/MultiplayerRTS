function draw_instance_movement_vector()
{

}


function draw_path_movement(){
	var old_color = draw_get_color()
	
	if(path_get_number(current_path)>0)
	{
		draw_set_color(c_blue)
		draw_path(current_path,x,y,true)
	
	}
	
	draw_set_color(old_color)
}

function flock_draw_radii(){
	var old_color=draw_get_alpha()
	var old_alpha=draw_get_alpha()
	
	//neighbour radius
	draw_set_color(c_lime)
	draw_set_alpha(0.2)
	draw_circle(x,y,flock_agent_neighbour_radius,false)
	
	draw_set_color(c_green)
	draw_set_alpha(0.4)
	draw_circle(x,y,flock_agent_neighbour_radius,true)
	
	//avoidance radius
	draw_set_color(c_red)
	draw_set_alpha(0.2)
	draw_circle(x,y,flock_agent_neighbour_radius*flock_agent_avoidance_factor,false)
	
	draw_set_alpha(0.4)
	draw_circle(x,y,flock_agent_neighbour_radius*flock_agent_avoidance_factor,true)
	
	
	//reset
	draw_set_color(old_color)
	draw_set_alpha(old_alpha)

}