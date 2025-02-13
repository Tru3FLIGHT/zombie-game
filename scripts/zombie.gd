class_name Zombie
extends Moveable

@export
var target: Node2D

func _ready() -> void:
	super()
	i_interface.parent = self
	i_interface.follow = target
