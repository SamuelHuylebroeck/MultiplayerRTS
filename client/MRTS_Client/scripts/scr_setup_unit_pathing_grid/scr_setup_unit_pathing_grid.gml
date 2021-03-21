function scr_setup_unit_pathing_grid(){
	var collision_map = layer_tilemap_get_id(layer_get_id("Tiles_Collision"))
	show_debug_message("Adding collision tiles")
	var nr_h_cells = floor(room_width/COLLISION_TILESIZE)
	var nr_v_cells = floor(room_height/COLLISION_TILESIZE)
	for (var i = 0; i< nr_h_cells; i++)
	{
		for (var j = 0 ; j<nr_v_cells ; j++)
		{
			var h =  i<<log2(COLLISION_TILESIZE)
			var v =  j<<log2(COLLISION_TILESIZE)
			if(tilemap_get_at_pixel(collision_map,h,v))
			{
				mp_grid_add_cell(global.pathing_grid, i,j)
			}
		}
		show_debug_message("Finished row " + string(i));
	}
	show_debug_message("finished adding collision tiles")
}