switch(state){
	case player_states.SELECTING:
		draw_selection_box()
		break;
	default:
		break;


}


function draw_selection_box(){
	var old_color = draw_get_color()
	var old_alpha = draw_get_alpha()
	
	draw_set_color(c_green)
	draw_set_alpha(1)
	draw_rectangle(pressed_x, pressed_y, mouse_x,mouse_y, true)
	draw_set_alpha(0.1)
	draw_rectangle_color(pressed_x, pressed_y, mouse_x,mouse_y,c_lime,c_lime,c_lime,c_lime,false)
	draw_set_color(old_color)
	draw_set_alpha(old_alpha)
}