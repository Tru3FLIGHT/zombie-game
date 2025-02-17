class_name AmmoBox
extends PickUp

signal ammo_box

 #freeing will be handled by the pickup spawn script
func player_interaction(_area: Area2D) -> void:
	emit_signal("ammo_box")