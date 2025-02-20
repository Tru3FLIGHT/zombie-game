class_name spawner
extends Node

@export
var base_spawn_chance: float:
	set(val):
		base_spawn_chance = clamp(val, 0.01, 1.0)
@onready
var parent = get_parent()
@onready
var difficulty = parent.difficulty
@onready
var difficulty_scale: float

var spawn_chance

#represents the outer bounds of the game, used to spawn items
const Y_RANGE := 700 #represents the height of the screen, actual coordinates are from -350 to 350
const X_RANGE := 1260 #represents the width of the screen, actual coordinates are from -630 to 630
@warning_ignore("integer_division")
const X_OFFSET := X_RANGE / 2
@warning_ignore("integer_division")
const Y_OFFSET := Y_RANGE / 2

func _process(_delta):
	difficulty = parent.difficulty
	difficulty_scale = scale_difficulty()
	spawn_chance = base_spawn_chance + difficulty_scale

func pick_item(spawn_distrobution: Dictionary, fallback: PackedScene) -> PackedScene:
	var roll = randf()
	var cumulative_chance = 0.0
	for item: PackedScene in spawn_distrobution.keys():
		cumulative_chance += spawn_distrobution[item]
		if roll < cumulative_chance:
			return item
	# Fallback in case something goes wrong
	return fallback

func spawn_item(instance) -> void:
	instance.global_position = gen_spawn()

#returns true if allowed to spawn an item
func try_spawn() -> bool:
	#print(spawn_chance)
	return randf() < spawn_chance

func gen_spawn() -> Vector2:
	return Vector2.ZERO

func scale_difficulty() -> float:
	return (difficulty / 100.0)*5.0

func instance_item(distrobution: Dictionary, fallback: PackedScene) -> void:
	var chosen = pick_item(distrobution, fallback)
	var instance = chosen.instantiate()
	spawn_item(instance)
	add_child(instance)
