class_name AmmoBox
extends PickUp

@warning_ignore("unused_signal")
signal ammo_box(amount: int)

func player_interaction(_area: Area2D) -> void:
	emit_signal("ammo_box", amount)
	queue_free()
