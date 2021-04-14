/// @description Gather context in movement states
switch(state)
{
	case unit_states.CHASE:
	case unit_states.ATTACK_MOVE:
	case unit_states.MOVE:
		get_context(swarm, self, ds_unit_context)
		break;
	default:
		break;
}
