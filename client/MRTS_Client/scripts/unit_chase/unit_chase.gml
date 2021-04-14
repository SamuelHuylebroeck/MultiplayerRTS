function unit_chase(){
	if(instance_exists(target))
	{
		current_speed = clamp(current_speed + unit_acceleration, 0, unit_max_speed)
		chase_movement_solo()
	
		//Transition to attack
		//Check if close enough to launch an attack
		var target_direction= point_direction(x,y, target.x, target.y)
		if (point_distance(x,y, target.x, target.y) <= unit_attack_range and abs(angle_difference(direction, target_direction) <= unit_move_angle_tolerance/2) and not attack_on_cooldown)
		{
			//show_debug_message("In range, perform attack")
			initialize_attack()
		}
	
		//De-aggro check
		var execute_deaggro = check_for_deaggro()
		if (execute_deaggro)
		{
			end_chase()
		}
	} else
	{
		end_chase()
	
	}
	
	
}

function chase_movement_solo()
{
	var neighbour_list = ds_list_create()
	collision_circle_list(x, y, unit_avoidance_radius , p_unit, false, true, neighbour_list, false);
	for(var i = 0; i<ds_list_size(neighbour_list);i++)
	{
		var neighbour = neighbour_list[|i]
	}
	
	if(target != noone and instance_exists(target))
	{
		var x_to = target.x;
		var y_to = target.y;
		
		var distance_to_go = point_distance(x,y, x_to, y_to);
		var speed_this_frame = current_speed;
		if( distance_to_go < current_speed) speed_this_frame = distance_to_go;
		var dir = point_direction(x,y,x_to, y_to);
		if (distance_to_go <= unit_attack_range)
		{
			speed_this_frame = 0
		}
		var h_speed = lengthdir_x(speed_this_frame, dir);
		var v_speed = lengthdir_y(speed_this_frame, dir);
		
		if( abs(angle_difference(direction, dir) > unit_move_angle_tolerance)){
			h_speed = 0;
			v_speed = 0;
		}

		unit_execute_turning(dir, unit_turn_rate_gs)
		scr_unit_execute_movement_and_collision(h_speed, v_speed)
		image_angle = direction
		
	}
	

}

function chase_movement_swarm(){
	if(target != noone and instance_exists(target))
	{
		var x_to = target.x;
		var y_to = target.y;
		var dir = point_direction(x,y,x_to, y_to);
		unit_execute_turning(dir, unit_turn_rate_gs)
		image_angle = direction
	}
}
function initialize_chase()
{
	state = unit_states.CHASE
	sprite_index = unit_state_sprite[state]
	aggro_counter = 2*aggro_check_interval
}
	
function end_chase()
{
	var context = ds_stack_pop(ds_order_memory_stack)
	if(not(context==undefined))
	{
		switch(context.context_state)
		{
			case unit_states.ATTACK_MOVE:
				end_chase_attack_move()
				break;
			case unit_states.GUARD:
				end_chase_move(context.g_x, context.g_y);
				break;
			default:
				state = unit_default_state
				break;
		}
	}else
	{
		state = unit_default_state
	} 
}

function end_chase_attack_move(){
	state = unit_states.ATTACK_MOVE
	target = noone
}

function end_chase_move(to_x, to_y){
	if (swarm != noone and instance_exists(swarm))
	{
		remove_unit_from_swarm(swarm, self)	
	}
	var ds_solo = ds_list_create()
	ds_list_add(ds_solo, self.id)
	create_movement_order(to_x, to_y, ds_solo, ord_attack_move, unit_states.ATTACK_MOVE)
	ds_list_destroy(ds_solo)

}