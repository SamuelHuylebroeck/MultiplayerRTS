//Select this unit
var this_unit = self
with(obj_local_player){
	clear_selection()
	if(this_unit.controlling_player == self.socket_id)
	{
		add_unit_to_selection(this_unit)
	}
}

