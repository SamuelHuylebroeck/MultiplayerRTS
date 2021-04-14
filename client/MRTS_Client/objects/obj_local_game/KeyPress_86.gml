/// @description Debug: Spawn in swarm
var nr_swarm_agents = 50;
var density = 0.5;
var base_radius = 10

var center_x = mouse_x
var center_y= mouse_y

var swarm = instance_create_layer(mouse_x,mouse_y,"Logic", obj_swarm)
if (not global.connected)
{
	for (var i=0; i<nr_swarm_agents;i++)
	{
		var r = random(1) * nr_swarm_agents/density*base_radius
		var alpha = random_range(0,360)
		
		var pos_x = center_x + lengthdir_x(r,alpha)
		var pos_y = center_y + lengthdir_y(r,alpha)
		var swarm_agent = instance_create_layer(pos_x, pos_y,"Instances", un_swarm_agent)
		swarm_agent.direction = random_range(0,360)
		swarm_agent.image_angle = swarm_agent.direction
		swarm_agent.controlling_player = local_player.id
		swarm_agent.state = unit_states.MOVE
		//swarm_agent.unit_override_colour = swarm.swarm_debug_colour
		ds_list_add(swarm.ds_swarm_agents,swarm_agent)
	}
}