class_name Zombie
extends Moveable

@export
var target: Node2D
@export
var damage: int = 10
@export
var attack_state: State
@export
var shots_to_kill: int = 1

@warning_ignore("integer_division")
var bullet_dmg: int = Health / shots_to_kill

func _ready() -> void:
	super()
	i_interface.parent = self
	i_interface.follow = target

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() == target:
		state_machine.change_state(attack_state)
	if area.get_parent() == Bullet:
		shot()


func shot() -> void:
	Health -= bullet_dmg
	death_check()
	
