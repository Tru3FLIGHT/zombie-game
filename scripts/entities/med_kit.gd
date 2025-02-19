class_name MedKit
extends PickUp

@warning_ignore("unused_signal")
signal med_kit(amount: int)

func _ready() -> void:
	connect("med_kit", Callable(get_parent(), "_on_med_kit_pickup"))

func player_interaction(_area: Area2D) -> void:
	emit_signal("med_kit", amount)
	queue_free()
