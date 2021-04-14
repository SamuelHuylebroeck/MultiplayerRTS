function create_attack_order(local_player, target, ds_units_to_order){
	if(local_player.order_state == order_states.ATTACK and local_player.id != target.controlling_player.id)
	{
		for(var i = 0; i< ds_list_size(local_player.selected_units); i++)
		{
			var unit_to_order = local_player.selected_units[| i]
			with(unit_to_order){
				clear_current_order()
				self.target = target
				initialize_chase()
				deaggro_counter = global.attack_aggro_cooldown * game_get_speed(gamespeed_fps)
			}
		}
	}
}

function send_attack_order(local_player, target, ds_units_to_order){

}
