//Execute statemachine
event_inherited();

if(!global.game_paused){
	if(unit_state_script[state] != -1){
		script_execute(unit_state_script[state])
	}
}