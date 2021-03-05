draw_self()

var old_halign = draw_get_halign()
var old_valign = draw_get_valign()

draw_set_halign(fa_middle)
draw_set_valign(fa_center)

draw_text(x,y-12, username)
draw_text(x,y, socket)
if ds_exists(unit_list, ds_type_list)
{
	draw_text(x,y+12, "Nr of active units: " +string(ds_list_size(unit_list)))
}

draw_set_halign(old_halign)
draw_set_valign(old_valign)

