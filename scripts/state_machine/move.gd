extends State

@export
var idle_state: State
@export 
var attack_state: State

var input_direction: Vector2
var direction: Vector2
var move_speed_adj: float


func enter():
	super()
	move_speed_adj = move_speed * 1000
	#print("move")

func process_input(_event: InputEvent) -> State:
	if i_interface.attack_input():
		return attack_state
	if i_interface.get_movement_direction() == Vector2.ZERO:
		return idle_state
	return null

func process_physics(delta: float) -> State:
	input_direction = i_interface.get_movement_direction()
	direction = ((parent.transform.x * input_direction.x) + (parent.transform.y * input_direction.y)).normalized()
	if direction:
		parent.velocity.x = direction.x * move_speed_adj * delta
		parent.velocity.y = direction.y * move_speed_adj * delta
	#print(parent.velocity)
	parent.move_and_slide()
	return null
	
func process_frame(_delta:float) -> State:
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
		animations.play(directional_anim())
	return null
