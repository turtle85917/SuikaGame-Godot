extends Node2D

const MAX_POS_X:int = 155;

func _physics_process(delta):
	var strength = Input.get_action_strength("right") - Input.get_action_strength("left");
	move_local_x(strength * 8);
	if(abs(transform.origin.x) > MAX_POS_X):
		transform.origin.x = min(max(transform.origin.x, -MAX_POS_X), MAX_POS_X);
		return;
