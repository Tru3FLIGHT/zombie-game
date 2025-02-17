extends Node

@export
var ammo_lower_bound: int = 1
@export
var ammo_upper_bound: int = 5

const Y_RANGE := 700
const Y_OFFSET := Y_RANGE / 2.0
const X_RANGE := 1260
const X_OFFSET := X_RANGE / 2.0

var ammo_box = preload("res://scenes/ammo_box.tscn")

signal ammo_pickup(amount: int)

@onready var ammo_timer: Timer = $ammo_timer

func _ready() -> void:
	ammo_timer.wait_time = randi_range(ammo_lower_bound, ammo_upper_bound)
	ammo_timer.start()
	ammo_timer.connect("timeout", Callable(self, "_on_ammo_timeout"))
	connect("ammo_pickup", Callable(get_parent(), "_on_ammo_pickup"))
	get_parent().connect("game_over", Callable(self, "_on_game_over"))
	

func _on_ammo_timeout() -> void:
	var spawnpoint: Vector2 = gen_spawnpoint()
	var instance = ammo_box.instantiate()
	instance.global_position = spawnpoint
	instance.connect("ammo_box", Callable(self, "_on_ammo_pickup"))
	add_child(instance)
	ammo_timer.wait_time = randi_range(ammo_lower_bound, ammo_upper_bound)

func _on_ammo_pickup(amount: int) -> void:
	emit_signal("ammo_pickup", amount)

func gen_spawnpoint() -> Vector2:
	@warning_ignore("narrowing_conversion")
	return Vector2(randi_range(-X_OFFSET/2.0, X_OFFSET/2.0), randi_range(-Y_OFFSET/2.0, Y_OFFSET/2.0))

func _on_game_over() -> void:
	for child in get_children():
		if child is PickUp:
			child.queue_free()
		ammo_timer.stop()
