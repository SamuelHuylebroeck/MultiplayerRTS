// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function unit_movement_server(){
	if target != noone {
		//Get direction of movement
		var x_to = target.x
		var y_to = target.y
		
		var dir = point_direction(x,y,x_to, y_to)
		//Execute turning
		direction = dir
		image_angle = direction
		//Accelerate
		var speed_this_frame = unit_max_speed
		 
		//Move
		h_speed=lengthdir_x(speed_this_frame, dir);
		v_speed = lengthdir_y(speed_this_frame, dir);
		scr_unit_execute_movement_and_collision()
		//Check if target is reached
		//TODO
	}
}