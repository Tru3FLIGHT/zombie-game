class_name PickUp
extends Area2D

var amount: int = 10

#freeing must be handled by inheriting classes
func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is PlayerCharacter:
		player_interaction(area)
		return
	non_player_interaction(area)


func player_interaction(area: Area2D) -> void:
	pass

func non_player_interaction(area: Area2D) -> void:
	pass
