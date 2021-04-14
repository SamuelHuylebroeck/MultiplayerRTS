function hornet_attack()
{
	if(floor(image_index) == 5 and  shots_fired = 0){
		fire_single_shot(proj_hornet, direction,9, 4,-1, -1)
		shots_fired++
	}
	
	if(floor(image_index) == 7 and  shots_fired = 1){
		fire_single_shot(proj_hornet, direction,9, -4,-1, -1)
		shots_fired++
	}

}

function hornet_attack_setup()
{
	shots_fired = 0
}