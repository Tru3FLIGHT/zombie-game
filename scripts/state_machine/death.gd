extends State

@onready var despawn: Timer = $despawn
@onready var hitbox: CollisionShape2D = $"../../hitbox"
@onready var area_2d: Area2D = $"../../Area2D"
@onready var world: Node = $"."
signal score(int)



func enter() -> void:
	connect("score", Callable(world, "_on_score"))
	super()
	despawn.start()
	hitbox.queue_free()
	area_2d.queue_free()
	emit_signal("score", parent.worth)
	disconnect("score", Callable(world, "_on_score"))

func _on_timer_timeout() -> void:
	parent.queue_free()
