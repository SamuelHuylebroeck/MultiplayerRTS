function reset_draw_state(old_color, old_alpha, old_halign, old_valign, old_font){
	draw_set_color(old_color)
	draw_set_alpha(old_alpha)
	draw_set_halign(old_halign)
	draw_set_valign(old_valign)
	draw_set_font(old_font)	
}

#region aggro
function set_up_draw_aggro(){
	draw_set_color(c_red)
	draw_set_alpha(1.0)

}

function draw_aggro_radius(){
	draw_circle(x,y,unit_aggro_radius, true)
}

function draw_target(){
	if(target != noone and instance_exists(target))
	{
		draw_arrow(x,y,target.x, target.y, 10)
	}

}
#endregion

#region state visualization

function set_up_draw_state(){
	draw_set_color(c_white)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
}

function draw_state(){
	var state_text;
	switch(state){
		case unit_states.CHASE:
			state_text = "C"
			break;
		case unit_states.ATTACK_MOVE:
			state_text = "AM"
			break;
		case unit_states.ATTACK:
			state_text = "A"
			break;
		case unit_states.GUARD:
			state_text = "G"
			break;
		case unit_states.MOVE:
			state_text = "M"
			break;
		case unit_states.IDLE:
			state_text = "I"
			break;
		default:
			state_text = "D"
	}
	draw_text(x,y, state_text)

}
#endregion

#region context visualization
function set_up_draw_context_swarm_mates(){
	draw_set_color(c_lime)
	draw_set_alpha(0.2)
}

function draw_context_swarm_mates(){
	for(var i = 0; i< ds_list_size(ds_unit_context); i++){
		var context = ds_unit_context[|i]
		if(context.is_part_of_swarm and not context.is_obstacle)
		{
			draw_line(x, y, context.pos_x, context.pos_y)
			draw_circle(context.pos_x, context.pos_y, 3, false)
			var x_to = lengthdir_x(10,context.dir)
			var y_to = lengthdir_y(10,context.dir)
			draw_arrow(context.pos_x,context.pos_y,context.pos_x+x_to,context.pos_y+y_to, 3)
		}
	}
}

function set_up_draw_context_obstacles(){
	draw_set_color(c_orange)
	draw_set_alpha(0.2)
}

function draw_context_obstacles(){
	for(var i = 0; i< ds_list_size(ds_unit_context); i++){
		var context = ds_unit_context[|i]
		if(not context.is_part_of_swarm and not context.is_obstacle)
		{
			draw_line(x, y, context.pos_x, context.pos_y)
			draw_circle(context.pos_x, context.pos_y, 5, false)
			var x_to = lengthdir_x(10,context.dir)
			var y_to = lengthdir_y(10,context.dir)
			draw_arrow(context.pos_x,context.pos_y,context.pos_x+x_to,context.pos_y+y_to, 3)
		}
	}
}

function set_up_draw_context_terrain(){
	draw_set_color(c_red)
	draw_set_alpha(0.2)
}

function draw_context_terrain(){
		for(var i = 0; i< ds_list_size(ds_unit_context); i++){
		var context = ds_unit_context[|i]
		if(context.is_obstacle)
		{
			draw_line(x, y, context.pos_x, context.pos_y)
			draw_circle(context.pos_x, context.pos_y, 5, false)
			var dir = point_direction(x, y, context.pos_x, context.pos_y)
			var x_to = lengthdir_x(10,dir)
			var y_to = lengthdir_y(10,dir)
			draw_arrow(context.pos_x,context.pos_y,context.pos_x+x_to,context.pos_y+y_to, 3)
		}
	}
}
#endregion