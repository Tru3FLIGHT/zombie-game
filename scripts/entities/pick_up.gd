class_name PickUp
extends Area2D


var amount: int

@export
var minimum: int = 1
@export
var maximum: int = 10

#freeing must be handled by inheriting classes
func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is PlayerCharacter:
		player_interaction(area)
		return
	non_player_interaction(area)

#no default behavior for player interaction
func player_interaction(_area: Area2D) -> void:
	pass

#default behavior is to destroy the pick up if a zombie touches it
func non_player_interaction(area: Area2D) -> void:
	if area.get_parent() is Zombie:
		queue_free()

func rand_amount() -> void:
	amount = randi() % (maximum - minimum) + minimum
