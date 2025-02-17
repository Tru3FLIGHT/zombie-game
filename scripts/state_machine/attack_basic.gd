class_name Attack
extends State

@export
var move_state:State
@export
var area: Area2D

@warning_ignore("unused_signal")
signal damage_event(damage: int)

func enter()-> void:
	super()
	connect("damage_event", Callable(parent.target, "_on_damage_event"))
	emit_signal("damage_event", parent.damage)
	disconnect("damage_event", Callable(parent.target, "_on_damage_event"))

func process_physics(_delta: float) -> State:
	if animations.is_playing():
		return null
	if contains_player():
		return self
	return move_state

func contains_player()-> bool:
	for a in area.get_overlapping_areas():
		if a.get_parent() is PlayerCharacter:
			return true
	return false
