var nr_flock_agents = 50;
var density = 0.5;
var base_radius = 10

var center_x = mouse_x
var center_y= mouse_y

//var flock = instance_create_layer(mouse_x,mouse_y,"Logic", obj_flock)
if (not global.connected)
{
	for (var i=0; i<nr_flock_agents;i++)
	{
		var r = random(1) * nr_flock_agents/density*base_radius
		var alpha = random_range(0,360)
		
		var pos_x = center_x + lengthdir_x(r,alpha)
		var pos_y = center_y + lengthdir_y(r,alpha)
		var flock_agent = instance_create_layer(pos_x, pos_y,"Instances", un_flock)
		flock_agent.direction = random_range(0,360)
		flock_agent.image_angle = flock_agent.direction
		flock_agent.controlling_player = local_player.id
		//ds_list_add(flock.ds_flock_agents, flock_agent)
	}
}