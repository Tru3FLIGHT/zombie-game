class_name Player
extends CharacterBody2D

enum facing {LEFT, RIGHT, UP, DOWN}

@export
var facing_direction := facing.DOWN

@onready
var animations = $Animations
@onready
var state_machine = $state_machine
@onready 
var raycast: RayCast2D = $raycast


func _ready() -> void:
	state_machine.init(self)
	
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	raycast.process_physics(facing_direction)
	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
