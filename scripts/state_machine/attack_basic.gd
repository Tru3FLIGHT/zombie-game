class_name Attack
extends State

@export
var move_state:State

func enter()-> void:
	super()
	

func process_physics(_delta: float) -> State:
	if animations.is_playing() == false:
		return move_state
	return null
