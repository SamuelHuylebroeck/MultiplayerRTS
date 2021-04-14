function damage_unit(unit, damage, source)
{
	with(unit)
	{
		unit_current_hp = max(0, unit_current_hp - damage)
		if(unit_current_hp <= 0)
		{
			instance_destroy()
		}
	}

}