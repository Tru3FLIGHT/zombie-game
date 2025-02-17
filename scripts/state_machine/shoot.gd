extends State


@export
var idle_state: State
@export
var move_state: State
var has_ammo: bool

var bullet = load("res://scenes/bullet.tscn")
var instance

func enter() -> void:
	super()
	if parent.ammo > 0:
		has_ammo = true
		parent.ammo -= 1
	else:
		has_ammo = false

func process_physics(_delta:float) -> State:
	if has_ammo:
		instance = bullet.instantiate()
		instance.position = parent.global_position
		if i_interface.get_movement_direction() == Vector2.ZERO:
			#parent.facing_direction returns a enum value, the direction must be a Vector2
			match parent.facing_direction:
				parent.facing.UP: instance.direction = Vector2(0, -1)
				parent.facing.DOWN: instance.direction = Vector2(0, 1)
				parent.facing.LEFT: instance.direction = Vector2(-1, 0)
				parent.facing.RIGHT: instance.direction = Vector2(1, 0)
		else:
			instance.direction = i_interface.get_movement_direction().normalized()
		parent.get_parent().add_child(instance)
		parent.move_and_slide()
	return determine_return()

func determine_return() -> State:
	if parent.velocity == Vector2.ZERO:
		return idle_state
	return move_state
