/// @description Toggle order attack state
switch(order_state){
	case order_states.ATTACK:
		order_state = order_states.MOVE;
		break;
	default:
		order_state = order_states.ATTACK
		break;

}
