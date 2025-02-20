class_name Bullet
extends CharacterBody2D

var SPEED = 1000
@onready var node_2d: Node2D = $"."
@onready var line_2d: Line2D = $Line2D
var direction: Vector2
var is_shotgun : bool = false
var passthorugh = 1

# Called when the node enters the scene tree for the first time.
@onready var timer: Timer = $Timer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta
	move_and_slide()


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Zombie:
		if passthorugh == 0:
			queue_free()
		if is_shotgun:
			passthorugh -= 1
			return
		queue_free()
