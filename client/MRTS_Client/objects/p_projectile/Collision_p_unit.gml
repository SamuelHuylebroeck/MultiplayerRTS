if(controlling_player != other.controlling_player and current_nr_impacts<projectile_max_nr_impacts and current_grace_distance<=0)
{
	//+show_debug_message("Projectile Impact")
	current_nr_impacts++
	current_grace_distance += projectile_impact_grace_distance
	damage_unit(other, projectile_damage, origin_unit)
	if(current_nr_impacts >= projectile_max_nr_impacts){
		alarm[0] = projectile_decay_seconds * game_get_speed(gamespeed_fps)
	}
}