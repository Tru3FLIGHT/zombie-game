class_name ai_interface
extends input_interface


var follow: Node2D


func get_movement_direction() -> Vector2:
	print(follow.position)
	print(parent.position)
	var a = (follow.global_position - parent.global_position).normalized()
	print(a)
	return a

func attack_input() -> bool:
	return false
