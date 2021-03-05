function get_unit_type(type_string){
	switch(type_string){
		case "hornet":
			return un_hornet
		default:
			show_debug_message("Requesting a type that does not exist")
			return -1;
			break;
	}
}