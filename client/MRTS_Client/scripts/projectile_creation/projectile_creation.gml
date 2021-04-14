function fire_single_shot(shot_type, angle, origin_correction_x, origin_correction_y, shot_sfx, sfx_emitter){
		//Calculate the correct coordinates to create the shot at by rotating the base vector along the current direction
		var c = dcos(angle)
		var s = dsin(angle)
		var shot_origin_correction_x = origin_correction_x * c + origin_correction_y *s;
		var shot_origin_correction_y = origin_correction_x * (-1*s) + origin_correction_y * c
		
		var shot_fired = instance_create_layer(x+shot_origin_correction_x,y+shot_origin_correction_y,"Instances",shot_type);
		if(shot_sfx != -1)
		{
			var sfx = audio_play_sound_on(sfx_emitter,shot_sfx,false,global.sfx_priority)
			audio_sound_gain(sfx, global.sfx_gain_base*global.sound_effect_scale*global.sound_master_scale,0)
			
		}
		with(shot_fired)
		{
			direction = angle
			image_angle = angle
			controlling_player = other.controlling_player
		}	
}