var unit_id_list = ds_list_create()

with(p_unit){
	ds_list_add(unit_id_list, self.id)

}
create_movement_order(mouse_x,mouse_y, unit_id_list, true)

ds_list_destroy(unit_id_list)