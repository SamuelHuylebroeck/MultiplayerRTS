/// @description Debug drawings

var old_color = draw_get_color()
var old_alpha = draw_get_alpha()
var old_valign = draw_get_halign()
var old_halign = draw_get_valign()
var old_font = draw_get_font()


#region aggro
if( global.debug_units_aggro){
	set_up_draw_aggro()
	with(p_unit){
		if (not global.debug_selected_only or selected){
			draw_aggro_radius()
			draw_target()
		}

	}
}
#endregion

#region states
if( global.debug_units_state){
	set_up_draw_state()
	with(p_unit)
	{
		if (not global.debug_selected_only or selected){
			draw_state()
		}

	}
}
#endregion
#region context
if(global.debug_units_movement_context){
	//Swarm mates
	set_up_draw_context_swarm_mates()
	with(p_unit)
	{
		if (not global.debug_selected_only or selected){
			draw_context_swarm_mates()
		}
	}
	//unit obstacles
	set_up_draw_context_obstacles()
	with(p_unit)
	{
		if (not global.debug_selected_only or selected){
			draw_context_obstacles()
		}
	}
	//terrain obstacles
	set_up_draw_context_terrain()
	with(p_unit)
	{
		if (not global.debug_selected_only or selected){
			draw_context_terrain()
		}
	}
	
}

#endregion
#region cleanup
reset_draw_state(old_color, old_alpha, old_halign, old_valign,old_font)
#endregion