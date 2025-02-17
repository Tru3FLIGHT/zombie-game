class_name PlayerCharacter
extends Moveable

var ammo: int = 25

signal ammo_changed

@onready var health_bar: ProgressBar = $HealthBar

func _on_area_2d_area_entered(area: Area2D) -> void:
	var attacker := area.get_parent()
	if attacker is Zombie:
		Health -= attacker.damage
		health_bar.health_changed()
		death_check()
		return
