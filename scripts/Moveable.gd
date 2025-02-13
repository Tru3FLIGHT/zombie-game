class_name Moveable
extends CharacterBody2D

enum facing {LEFT, RIGHT, UP, DOWN}

@export
var facing_direction := facing.DOWN

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
	#print(transform)
	state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
