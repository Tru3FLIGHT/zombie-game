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

var bullet_dmg: int


func _ready() -> void:
	super()
	@warning_ignore("integer_division")
	bullet_dmg = Health / shots_to_kill
	i_interface.parent = self
	i_interface.follow = target

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() == target:
		state_machine.change_state(attack_state)
	if area.get_parent() is Bullet:
		shot()

func shot() -> void:
	Health -= bullet_dmg
	death_check()
