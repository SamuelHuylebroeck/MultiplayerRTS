function clear_selection(){
	//deselect the units
	for (var i =0; i<ds_list_size(selected_units); i++)
	{
		var unit = ds_list_find_value(selected_units, i)
		unit.selected = false;
	}
	//clear the list
	ds_list_clear(selected_units)
}

function add_unit_to_selection(unit){
	unit.selected = true
	ds_list_add(selected_units, unit)
}


function select_units_in_rectangle(pressed_x, pressed_y, released_x, released_y, controlling_player){
	
	//show_debug_message("passed rectangle: [" +string(pressed_x)+","+string(pressed_y)+"] -> ["+string(released_x)+","+string(released_y) +"]")
	//Get rectangle coordinates
	var tl_x = min(pressed_x, released_x)
	var tl_y = min(pressed_y, released_y)
	
	//Create sensor object
	if(not instance_exists(obj_sensor))
	{
		instance_create_depth(0,0,0,obj_sensor)
	}

	
	var width = abs(pressed_x - released_x)
	var height = abs(pressed_y - released_y)
	
	//show_debug_message("refined rectangle: [" +string(tl_x)+","+string(tl_y)+"] -> ["+string(tl_x+width)+","+string(tl_y+height) +"]")

	
	//Setup sensor object
	obj_sensor.image_xscale = width / sprite_get_width(obj_sensor.sprite_index)
	obj_sensor.image_yscale = height / sprite_get_height(obj_sensor.sprite_index)
	
	
	//show_debug_message("Selection rectangle:[" +string(tl_x)+","+string(tl_y)+"] -> ["+string(tl_x+ obj_sensor.sprite_width)+","+string(tl_y+ obj_sensor.sprite_height) +"]")
	//unit detection detection
	var ds_units_in_box = ds_list_create()
	var nr_candidates = 0
	with(obj_sensor)
	{
		nr_candidates = instance_place_list(tl_x,tl_y, p_unit, ds_units_in_box, false)
	}
	if(nr_candidates > 0){
		show_debug_message("Nr of candidate units: "+string(nr_candidates))
		for(var i =0; i< nr_candidates; i++)
		{
			var candidate = ds_units_in_box[|i]
			if (candidate.controlling_player = controlling_player)
			{
				candidate.selected = true
				ds_list_add(selected_units, candidate)
			}
		
		}
	}
	
	ds_list_destroy(ds_units_in_box)


}