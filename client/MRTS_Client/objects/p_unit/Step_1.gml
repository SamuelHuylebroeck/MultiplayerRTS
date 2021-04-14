/// @description Gather context in movement states
switch(state)
{
	case unit_states.CHASE:
	case unit_states.ATTACK_MOVE:
	case unit_states.MOVE:
		ds_list_clear(ds_unit_context)
		get_context(swarm, self, ds_unit_context, true)
		break;
	default:
		break;
}
