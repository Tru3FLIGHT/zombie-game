class_name Bullet
extends CharacterBody2D

var SPEED = 1000
@onready var node_2d: Node2D = $"."
@onready var line_2d: Line2D = $Line2D
var direction: int
var d: Vector2

# Called when the node enters the scene tree for the first time.
@onready var timer: Timer = $Timer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	match direction:
		0: d = Vector2.LEFT
		1: d = Vector2.RIGHT
		2: d = Vector2.UP
		3: d = Vector2.DOWN
	position += d * SPEED * delta
	move_and_slide()
	

func _on_timer_timeout() -> void:
	queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Zombie:
		queue_free()
