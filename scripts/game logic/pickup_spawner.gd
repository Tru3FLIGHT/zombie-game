extends Node

@export
var ammo_amount: int
var health_ammount: int

const Y_RANGE := 700
@warning_ignore("integer_division")
const Y_OFFSET := Y_RANGE / 2
const X_RANGE := 1260
@warning_ignore("integer_division")
const X_OFFSET := X_RANGE / 2

var ammo_box = preload("res://scenes/ammo_box.tscn")

signal ammo_pickup(amount: int)

@onready var pickup_timer: Timer = $pickup_timer

func _ready() -> void:
	pickup_timer.wait_time = randi_range(1,3)
	pickup_timer.start()
	pickup_timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	connect("ammo_pickup", Callable(get_parent(), "_on_ammo_pickup"))
	

func _on_timer_timeout() -> void:
	@warning_ignore("narrowing_conversion")
	var spawnpoint: Vector2 = Vector2(randi_range(-X_OFFSET/2.0, X_OFFSET/2.0), randi_range(-Y_OFFSET/2.0, Y_OFFSET/2.0))
	var instance = ammo_box.instantiate()
	instance.global_position = spawnpoint
	instance.connect("ammo_box", Callable(self, "_on_ammo_pickup"))
	add_child(instance)

func _on_ammo_pickup(amount: int) -> void:
	emit_signal("ammo_pickup", amount)

func _on_game_over() -> void:
	for child in get_children():
		if child is PickUp:
			child.queue_free()
		else:
			pickup_timer.stop()
