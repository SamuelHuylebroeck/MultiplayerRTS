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