class_name MedKit
extends PickUp

@warning_ignore("unused_signal")
signal med_kit(amount: int)

func player_interaction(_area: Area2D) -> void:
	emit_signal("med_kit", amount)
	queue_free()
