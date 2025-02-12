extends State

@export
var idle_state: State
@export 
var attack_state: State

var target_direction: Vector2
var input_direction: Vector2
var direction: Vector2

func enter():
	super()
	print("move")

func process_input(event: InputEvent) -> State:
	target_direction.x = 0
	target_direction.y = 0
	if Input.is_action_just_pressed("shoot"):
		return attack_state
	if !is_movement_action():
		return idle_state
	return null

func process_physics(delta: float) -> State:
	input_direction = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down") 
	direction = ((parent.transform.x * input_direction.x) + (parent.transform.y * input_direction.y)).normalized()
	if direction:
		parent.velocity.x = direction.x * move_speed
		parent.velocity.y = direction.y * move_speed
	#print(parent.velocity)
	parent.move_and_slide()
	return null
	
func process_frame(delta:float) -> State:
	if direction:
		if direction.x != 0:
			if direction.x < 0:
				parent.facing_direction = parent.facing.LEFT
			else:
				parent.facing_direction = parent.facing.RIGHT
		elif direction.y < 0:
			parent.facing_direction = parent.facing.UP
		elif direction.y > 0:
			parent.facing_direction = parent.facing.DOWN
		else :
			return null
		parent.animations.play(directional_anim())
	return null

func is_movement_action() -> bool:
	if Input.is_action_pressed("walk_up") or Input.is_action_pressed("walk_right") or Input.is_action_pressed("walk_left") or Input.is_action_pressed("walk_down"):
		return true
	return false
