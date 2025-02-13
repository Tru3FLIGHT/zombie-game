class_name input_interface
extends Node

var parent: CharacterBody2D

func get_movement_direction() -> Vector2:
	return Vector2(0,0)

func attack_input() -> bool:
	return false
	
