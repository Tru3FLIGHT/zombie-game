class_name PlayerCharacter
extends Moveable

signal health_changed

func _on_area_2d_area_entered(area: Area2D) -> void:
	var attacker := area.get_parent()
	if attacker is Zombie:
		Health -= attacker.damage
		emit_signal("health_changed")
		death_check()
