var unit = self
var controller = self.controlling_player
 
with(obj_mouse){
	local_player.mouse_enter_player_state = local_player.state
	local_player.mouse_enter_order_state = local_player.order_state
	if(controller != local_player.id)
	{
		local_player.order_state = order_states.ATTACK
	}
}