extends State


@export
var idle_state: State
@export
var move_state: State

var bullet = load("res://scenes/bullet.tscn")
var instance

func enter() -> void:
	super()

func process_physics(_delta:float) -> State:
	instance = bullet.instantiate()
	instance.position = parent.global_position
	instance.direction = parent.facing_direction
	parent.get_parent().add_child(instance)
	parent.move_and_slide()
	return determine_return()
	
	
func determine_return() -> State:
	if Vector2.ZERO:
		return idle_state
	return move_state
