function debug_draw_swarm_context(swarm_agent, context_list)
{
	var old_color = draw_get_color()
	//Swarm mates in green
	draw_set_color(c_green)
	for(var i = 0; i< ds_list_size(context_list); i++){
		var context = context_list[|i]
		if(context[3])
		{
			draw_line(swarm_agent.x, swarm_agent.y, context[0], context[1])
			draw_circle(context[0], context[1], 7, false)
			var x_to = lengthdir_x(10,context[2])
			var y_to = lengthdir_y(10,context[2])
			draw_arrow(context[0],context[1],context[0]+x_to,context[1]+y_to, 3)
		
		}

	}
	//obstacles in red
	draw_set_color(c_red)
	for(var i = 0; i< ds_list_size(context_list); i++){
		var context = context_list[|i]
		if(not context[3])
		{
			draw_line(swarm_agent.x, swarm_agent.y, context[0], context[1])
			draw_circle(context[0], context[1], 5, false)
			var x_to = lengthdir_x(10,context[2])
			var y_to = lengthdir_y(10,context[2])
			draw_arrow(context[0],context[1],context[0]+x_to,context[1]+y_to, 3)
		
		}
	}
	
	draw_set_color(old_color)
	
}


function debug_draw_swarm_movement_contributions(swarm_agent, context_list, weights)
{
	var old_color = draw_get_color()
	var vis_scale = global.debug_units_swarm_movement_contributions_scale
	
	draw_set_color(c_green)
	var result_c_steered = calculate_move_steered_cohesion(swarm_agent, ds_agent_context, true)
	draw_arrow(swarm_agent.x, swarm_agent.y, swarm_agent.x + weights[0] * result_c_steered[0]*vis_scale,swarm_agent.y + weights[0] * result_c_steered[1]*vis_scale,2 )
	
	draw_set_color(c_olive)
	var result_al = calculate_move_alignment(swarm_agent, ds_agent_context, true)
	draw_arrow(swarm_agent.x, swarm_agent.y, swarm_agent.x + weights[1] * result_al[0]*vis_scale,swarm_agent.y + weights[1] * result_al[1]*vis_scale,2 )
	
	draw_set_color(c_red)
	var result_av = calculate_move_avoidance(swarm_agent, ds_agent_context)
	draw_arrow(swarm_agent.x, swarm_agent.y, swarm_agent.x + weights[2] * result_av[0]*vis_scale,swarm_agent.y + weights[2] * result_av[1]*vis_scale,2 )
	
	draw_set_color(c_orange)
	var result_stay_in_radius = calculate_move_stay_in_radius(swarm_agent,ds_agent_context,self, swarm_radius, swarm_deadzone)
	draw_arrow(swarm_agent.x, swarm_agent.y, swarm_agent.x + weights[2] * result_stay_in_radius[0]*vis_scale,swarm_agent.y + weights[2] * result_stay_in_radius[1]*vis_scale,2 )
	
	//draw_set_color(c_fuchsia)
	//var result_stay_on_target = calculate_move_stay_on_target(swarm_agent, ds_agent_context, swarm_radius, swarm_deadzone)
	//draw_arrow(swarm_agent.x, swarm_agent.y, swarm_agent.x + weights[2] * result_stay_on_target[0]*vis_scale,swarm_agent.y + weights[2] * result_stay_on_target[1]*vis_scale,2 )
	
	draw_set_color(c_black)
	var proposed_move = swarm_calculate_move_improved(swarm_agent, swarm_weights)
	draw_arrow(swarm_agent.x, swarm_agent.y, swarm_agent.x+proposed_move[0], swarm_agent.y+proposed_move[1], 2)
	draw_set_color(old_color)
}