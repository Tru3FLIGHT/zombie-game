extends spawner

const pickup_distrobution = {
	ammo_box: 0.34,
	first_aid: 0.33,
	med_kit: 0.33
	}

@export
var deadzone: float = 1

const ammo_box = preload("res://scenes/ammo_box.tscn")
const first_aid = preload("res://scenes/first_aid.tscn")
const med_kit = preload("res://scenes/med_kit.tscn")

@warning_ignore("unused_signal")
signal ammo_pickup(amount: int)
@warning_ignore("unused_signal")
signal first_aid_pickup(amount: int)
@warning_ignore("unused_signal")
signal med_kit_pickup(amount: int)

@onready var timer: Timer = $pickup_timer


func _ready() -> void:
	timer.wait_time = 2
	timer.start()
	timer.connect("timeout", Callable(self, "_on_pickup_timer_timeout"))
	connect("ammo_pickup", Callable(get_parent(), "_on_ammo_pickup"))
	connect("first_aid_pickup", Callable(get_parent(), "_on_first_aid_pickup"))
	connect("med_kit_pickup", Callable(get_parent(), "_on_med_kit_pickup"))
	get_parent().connect("game_over", Callable(self, "_on_game_over"))

func _on_pickup_timer_timeout() -> void:
	randomize()
	if try_spawn():
		instance_item(pickup_distrobution, ammo_box)

func gen_spawn() -> Vector2:
	@warning_ignore("narrowing_conversion")
	var x := randi_range(-X_OFFSET*deadzone, X_OFFSET*deadzone)
	@warning_ignore("narrowing_conversion")
	var y := randi_range(-Y_OFFSET*deadzone, Y_OFFSET*deadzone)
	return Vector2(x, y)

func scale_difficulty() -> float:
	return -(difficulty / 100.0)*5

func _on_ammo_pickup(amount: int) -> void:
	emit_signal("ammo_pickup", amount)

func _on_first_aid_pickup(amount: int) -> void:
	emit_signal("first_aid_pickup", amount)

func _on_med_kit_pickup(amount: int) -> void:
	emit_signal("med_kit_pickup", amount)

func _on_game_over() -> void:
	timer.stop()
	for child in get_children():
		if child is PickUp:
			child.queue_free()
