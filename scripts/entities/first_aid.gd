class_name FirstAid 
extends PickUp

@warning_ignore("unused_signal")
signal first_aid(amount: int)

func player_interaction(_area: Area2D) -> void:
	emit_signal("first_aid", amount)
	queue_free()