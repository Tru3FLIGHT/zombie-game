class_name ai_interface
extends input_interface


var follow: Node2D


func get_movement_direction() -> Vector2:
	return (follow.global_position - parent.global_position).normalized()

func attack_input() -> bool:
	return false
