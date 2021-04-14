//Move every member of the flock
swarm_execute_movement()

if(ds_list_size(ds_swarm_agents) <= 0)
{
	instance_destroy()
}