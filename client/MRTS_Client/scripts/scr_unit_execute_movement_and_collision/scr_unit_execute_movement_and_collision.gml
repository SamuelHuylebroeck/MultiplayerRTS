function scr_unit_execute_movement_and_collision(){
	var colliding = false;

	//Horizontal Tiles
	//if(tilemap_get_at_pixel(collision_map, x+ h_speed, y) and enemy_apply_tile_collision)
	//{
	//	x -= x mod COLLISION_TILESIZE; //move to pixel one of the tile (left)
	//	if(sign(h_speed) == 1) x += COLLISION_TILESIZE -1 //move to  (shift to right)
	//	colliding = true
	//	h_speed = 0
	//}
	
	//Horizontal Move Commit
	x+=h_speed
	

	//Vertical Tiles
    //if(tilemap_get_at_pixel(collision_map, x, y+v_speed) and enemy_apply_tile_collision)
	//{
	//	y -= y mod COLLISION_TILESIZE; //move to pixel one of the tile (bottom)
	//	if(sign(v_speed) == 1) y+= COLLISION_TILESIZE -1 //move to  (shift to top)
	//	colliding = true
	//	v_speed = 0
	//}
	
	//Vertical Move Commit
	y+=v_speed

	return colliding
}