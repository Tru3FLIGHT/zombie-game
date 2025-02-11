extends State

@export
var move_state: State
@export
var attack_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("shoot"):
		return attack_state
	if Input.is_action_just_pressed("walk_left") or Input.is_action_just_pressed("walk_right") or Input.is_action_just_pressed("walk_up") or Input.is_action_just_pressed("walk_down"):
		return move_state
	return null
