extends Node2D

var SPEED = 40.0
@onready var node_2d: Node2D = $"."
@onready var line_2d: Line2D = $Line2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += transform * Vector2(0,SPEED) * delta
