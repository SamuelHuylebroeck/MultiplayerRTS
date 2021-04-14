image_angle=direction

if(speed < projectile_max_speed){
	speed = clamp(speed + projectile_acceleration, 0, projectile_max_speed)
}
distance_travelled += speed
current_grace_distance = max(0, current_grace_distance-speed) 

if(distance_travelled > projectile_max_distance)
{
	alarm[0] = 0
}