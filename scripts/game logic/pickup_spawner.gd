extends Node

@export
var ammo_lower_bound: int = 2
@export
var ammo_upper_bound: int = 7
@export
var first_aid_lower_bound: int = 4
@export
var first_aid_bound: int = 15
@export
var med_kit_lower_bound: int = 4
@export
var med_kit_bound: int = 15


const Y_RANGE := 700
const Y_OFFSET := Y_RANGE / 2.0
const X_RANGE := 1260
const X_OFFSET := X_RANGE / 2.0

const ammo_box = preload("res://scenes/ammo_box.tscn")
const first_aid = preload("res://scenes/first_aid.tscn")
const med_kit = preload("res://scenes/med_kit.tscn")

@warning_ignore("unused_signal")
signal ammo_pickup(amount: int)
@warning_ignore("unused_signal")
signal first_aid_pickup(amount: int)
@warning_ignore("unused_signal")
signal med_kit_pickup(amount: int)

@onready var ammo_timer: Timer = $ammo_timer
@onready var first_aid_timer: Timer = $first_aid_timer
@onready var med_kit_timer: Timer = $med_kit_timer

func _ready() -> void:
	timer_setup()

	connect("ammo_pickup", Callable(get_parent(), "_on_ammo_pickup"))
	connect("first_aid_pickup", Callable(get_parent(), "_on_first_aid_pickup"))
	connect("med_kit_pickup", Callable(get_parent(), "_on_med_kit_pickup"))
	get_parent().connect("game_over", Callable(self, "_on_game_over"))


#AMMO
######################
func _on_ammo_timeout() -> void:
	var instance = ammo_box.instantiate()
	spawn(instance, ammo_timer, ammo_lower_bound, ammo_upper_bound)
	instance.connect("ammo_box", Callable(self, "_on_ammo_pickup"))

func _on_ammo_pickup(amount: int) -> void:
	emit_signal("ammo_pickup", amount)
######################

#FIRST AID
######################
func _on_first_aid_timeout() -> void:
	var instance = first_aid.instantiate()
	spawn(instance, first_aid_timer, first_aid_lower_bound, first_aid_bound)
	instance.connect("first_aid", Callable(self, "_on_first_aid_pickup"))

func _on_first_aid_pickup(amount: int) -> void:
	emit_signal("first_aid_pickup", amount)
######################

#MED KIT
######################
func _on_med_kit_timeout() -> void:
	var instance = med_kit.instantiate()
	spawn(instance, med_kit_timer, med_kit_lower_bound, med_kit_bound)
	instance.connect("med_kit", Callable(self, "_on_med_kit_pickup"))

func _on_med_kit_pickup(amount: int) -> void:
	emit_signal("med_kit_pickup", amount)
######################

func spawn(instance: PickUp, timer: Timer, lower: int, upper: int) -> void:
	var spawnpoint: Vector2 = gen_spawnpoint()
	instance.global_position = spawnpoint
	add_child(instance)
	timer.wait_time = randi_range(lower, upper)

func gen_spawnpoint() -> Vector2:
	@warning_ignore("narrowing_conversion")
	return Vector2(randi_range(-X_OFFSET/2.0, X_OFFSET/2.0), randi_range(-Y_OFFSET/2.0, Y_OFFSET/2.0))

func _on_game_over() -> void:
	ammo_timer.stop()
	first_aid_timer.stop()
	med_kit_timer.stop()
	for child in get_children():
		if child is PickUp:
			child.queue_free()
			

func timer_setup() -> void:
	#ammo timer
	ammo_timer.wait_time = randi_range(ammo_lower_bound, ammo_upper_bound)
	ammo_timer.start()
	ammo_timer.connect("timeout", Callable(self, "_on_ammo_timeout"))

	#first aid timer
	first_aid_timer.wait_time = randi_range(ammo_lower_bound, ammo_upper_bound)
	first_aid_timer.start()
	first_aid_timer.connect("timeout", Callable(self, "_on_first_aid_timeout"))
	
	#med kit timer
	med_kit_timer.wait_time = randi_range(med_kit_lower_bound, med_kit_bound)
	med_kit_timer.start()
	med_kit_timer.connect("timeout", Callable(self, "_on_med_kit_timeout"))
