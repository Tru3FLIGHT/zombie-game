extends State

@export
var move_state: State
@export
var attack_state: State

func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO

func process_input(_event: InputEvent) -> State:
	#check the control engine for the relevant controls
	if i_interface.attack_input():
		return attack_state
	if i_interface.get_movement_direction() != Vector2.ZERO:
		return move_state
	return null
