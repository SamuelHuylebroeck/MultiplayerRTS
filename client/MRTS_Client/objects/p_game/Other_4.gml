//Set camera corectly
var room_viewport_values = room_get_viewport(room,0)
camera_set_view_target(view_camera[0], obj_mouse)
window_set_cursor(cr_none);

//Setup pathing grid
if (room != room_lobby and room != room_menu)
{
	//layer_set_visible("Tiles_Collision", true)
	//global.pathing_grid = mp_grid_create(0,0, floor(room_height/COLLISION_TILESIZE), floor(room_width/COLLISION_TILESIZE), COLLISION_TILESIZE, COLLISION_TILESIZE);
	//scr_setup_unit_pathing_grid()
}

