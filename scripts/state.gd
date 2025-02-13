class_name State
extends Node

@export
var animation_up: String
@export
var animation_down: String
@export
var animation_left: String
@export
var animation_right: String
@export
var move_speed: float = 400

#referance to the parent class to be initalized by state_machine
var parent: CharacterBody2D
var animations: AnimatedSprite2D
var i_interface: input_interface

func enter() -> void:
	animations.play(directional_anim())
	
func exit() -> void:
	pass
	
func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
	
	#parent enum is as follows:{LEFT, RIGHT, UP, DOWN}
func directional_anim() -> String:
	match parent.facing_direction:
		0:
			return animation_left
		1:
			return animation_right
		2:
			return animation_up
		3:
			return animation_down
		_:
			return ""
