if ds_exists(unit_list, ds_type_list)
{
	for(var i = 0; i< ds_list_size(unit_list); i++)
	{
		var unit = unit_list[|i]
		with(unit){
			instance_destroy()
		}
	}
	
	ds_list_destroy(unit_list)
}