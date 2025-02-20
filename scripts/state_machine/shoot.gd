extends State


@export
var idle_state: State
@export
var move_state: State
var has_ammo: bool
var has_shotgun_ammo: bool
var shotgun_spread : float = 5

var bullet = load("res://scenes/bullet.tscn")
var instance

func enter() -> void:
	super()
	get_ammo_types()

func process_physics(_delta:float) -> State:
	parent.move_and_slide()
	if has_shotgun_ammo:
		instance_bullet(0)
		instance_bullet(shotgun_spread)
		instance_bullet(-shotgun_spread)
		return determine_return()
	if has_ammo:
		instance_bullet(0)
	return determine_return()

func determine_return() -> State:
	if parent.velocity == Vector2.ZERO:
		return idle_state
	return move_state

func get_fire_direction(offset:float) -> Vector2:
	var direction : Vector2
	if i_interface.get_movement_direction() == Vector2.ZERO:
		#parent.facing_direction returns a enum value, the direction must be a Vector2
		match parent.facing_direction:
			parent.facing.UP: direction = Vector2(0, -1)
			parent.facing.DOWN: direction = Vector2(0, 1)
			parent.facing.LEFT: direction = Vector2(-1, 0)
			parent.facing.RIGHT: direction = Vector2(1, 0)
	else:
		direction = i_interface.get_movement_direction().normalized()
	#the offset is used to determine the spread of the shotgun
	#it will alter the vector by the offset (degrees)
	direction = direction.rotated(deg_to_rad(offset))
	return direction

func instance_bullet(offset: float) -> void:
	instance = bullet.instantiate()
	instance.position = parent.global_position
	instance.direction = get_fire_direction(offset)
	parent.get_parent().add_child(instance)
	

func get_ammo_types() -> void:
	if parent.shotgun_ammo > 0:
		has_shotgun_ammo = true
		parent.shotgun_ammo -= 1
		return
	else:
		has_shotgun_ammo = false

	if parent.ammo > 0:
		has_ammo = true
		parent.ammo -= 1
	else:
		has_ammo = false
