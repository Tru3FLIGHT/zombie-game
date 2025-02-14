extends State

@onready var despawn: Timer = $despawn
@onready var hitbox: CollisionShape2D = $"../../hitbox"
@onready var area_2d: Area2D = $"../../Area2D"

func enter() -> void:
	super()
	
	despawn.start()
	hitbox.queue_free()
	area_2d.queue_free()

func _on_timer_timeout() -> void:
	parent.queue_free()
