class_name ShotgunAmmo
extends PickUp

@warning_ignore("unused_signal")
signal shotgun_ammo(amount: int)

func _ready() -> void:
	connect("shotgun_ammo", Callable(get_parent(), "_on_shotgun_ammo_pickup"))

func player_interaction(_area: Area2D) -> void:
	rand_amount()
	emit_signal("shotgun_ammo", amount)
	queue_free()
