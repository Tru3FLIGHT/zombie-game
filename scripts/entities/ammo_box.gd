class_name AmmoBox
extends PickUp

@export
var min: int
@export
var max: int

@warning_ignore("unused_signal")
signal ammo_box(amount: int)

func _ready() -> void:
	connect("ammo_box", Callable(get_parent(), "_on_ammo_pickup"))

func player_interaction(_area: Area2D) -> void:
	amount = randi_range(min, max)
	emit_signal("ammo_box", amount)
	queue_free()
