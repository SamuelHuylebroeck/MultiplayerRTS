// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function clear_current_order(){
	if(current_order != noone)
	{
		var unit = self
		with(current_order){
			execute_clear_order(unit)
		}
		current_order = noone
	}
}


function execute_clear_order(ordered_unit){
	switch object_index{
		case ord_move:
			execute_clear_movement_order(ordered_unit)
			break;
		case ord_attack_move:
			execute_clear_movement_order(ordered_unit)
			break;
		default:
			break;
	}

}


function execute_clear_movement_order(ordered_unit){
	clear_from_swarm(ordered_unit)
	clear_from_list(ordered_unit)
	if(ds_list_size(ds_ordered_units) <= 0){
		instance_destroy()
	}	
}

function clear_from_list(ordered_unit){
	var index = ds_list_find_index(ds_ordered_units, ordered_unit.id)
	if(index!=-1){
		ds_list_delete(ds_ordered_units, index)
	}

}

function clear_from_swarm(ordered_unit){
	if(swarm !=noone)
	{
		remove_unit_from_swarm(swarm, ordered_unit)
	}
}

function remove_unit_from_swarm(swarm, unit)
{
	with(swarm)
	{
		var swarm_index = ds_list_find_index(ds_swarm_agents, unit.id)
		if (swarm_index != -1){
			ds_list_delete(ds_swarm_agents, swarm_index)
			if(ds_list_size(ds_swarm_agents) <= 0)
			{
				instance_destroy()
			}	
		}
	}
}