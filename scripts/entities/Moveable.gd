class_name Moveable
extends CharacterBody2D

signal player_died

enum facing {LEFT, RIGHT, UP, DOWN}

@export
var death_state: State
@export
var facing_direction := facing.DOWN
@export
var Health: int = 100

@onready
var animations = $Animations
@onready
var state_machine = $state_machine
@onready
var i_interface: Node = $input_interface

func _ready() -> void:
	state_machine.init(self, animations, i_interface)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)

	
func death_check() -> void:
	if Health <= 0:
		emit_signal("player_died")
		state_machine.change_state(death_state)
