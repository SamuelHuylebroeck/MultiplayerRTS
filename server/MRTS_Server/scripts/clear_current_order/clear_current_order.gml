// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function clear_current_order(){
	if(current_order != noone)
	{
		var unit = self
		with(current_order){
			var index = ds_list_find_index(ds_ordered_units, unit.id)
			if(index!=-1){
				ds_list_delete(ds_ordered_units, index)
			}
			if(ds_list_size(ds_ordered_units) <= 0){
				instance_destroy()
			}	
		}
		current_order = noone
	}
}