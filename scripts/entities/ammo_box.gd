class_name AmmoBox
extends PickUp

signal ammo_box(amount: int)

func _ready() -> void:
	amount = 5

func player_interaction(_area: Area2D) -> void:
	emit_signal("ammo_box", amount)
	queue_free()
