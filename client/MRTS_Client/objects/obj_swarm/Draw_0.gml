if(global.debug_units_swarm){
	var old_color = draw_get_color()
	var old_alpha = draw_get_alpha()
	
	var color = swarm_active ? c_aqua : c_green
	draw_set_color(color)
	draw_set_alpha(0.10)
	draw_circle(x,y, swarm_radius,false)
	
	draw_set_color(color)
	draw_set_alpha(0.05)
	draw_circle(x,y, swarm_radius*swarm_deadzone,false)

	draw_set_color(old_color)
	draw_set_alpha(old_alpha)
}

#region individual agent debugging
//Move every member of the flock
for(var i =0; i< ds_list_size(ds_swarm_agents);i++){
	var swarm_agent = ds_swarm_agents[|i]
	if(instance_exists(swarm_agent))
	{
		if(global.debug_units_swarm_movement_contributions and (swarm_agent.selected or not global.debug_selected_only)){
			//Draw vector individual component contributions
			debug_draw_swarm_movement_contributions(swarm_agent, swarm_agent.ds_unit_context, swarm_weights)
		}
	}
}

#endregion