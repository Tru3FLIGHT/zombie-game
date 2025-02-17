extends Node

#represents the outer bounds of the game, used to spawn zombies
const Y_RANGE := 700 #represents the height of the screen, actual coordinates are from -350 to 350
const X_RANGE := 1260 #represents the width of the screen, actual coordinates are from -630 to 630
@warning_ignore("integer_division")
const X_OFFSET := X_RANGE / 2
@warning_ignore("integer_division")
const Y_OFFSET := Y_RANGE / 2
@onready 
var timer: Timer = $zombie_timer

@onready var target: PlayerCharacter = $"../player"

const ZOMBIE = preload("res://scenes/zombie.tscn")

#every time the timer times out a new zombie is spawned
#the timer is reset to a random value based on the difficulty,
#the zombies will spawn at a random location on the edge of the screen
#first we will choose whether to spawn on the x or y axis
#then we will choose a random location on the chosen axis and pick a random side

#the spawn times will be based on a base value, that value will be devide by the difficulty level

func _ready() -> void:
	timer.wait_time = randf_range(1,3)
	timer.start()
	get_parent().connect("game_over", Callable(self, "_on_game_over"))

func _on_zombie_timer_timeout() -> void:
	timer.wait_time = randf_range(1,3)
	var instance = ZOMBIE.instantiate()
	spawn_zombie(instance)
	add_child(instance)

func spawn_zombie(instance: Zombie) -> void:
	var spawn = gen_spawn()
	instance.target = target
	instance.global_position = spawn

func gen_spawn() -> Vector2:
	var spawn: Vector2
	var spawn_side := randi_range(0,1) #0 is x, 1 is y
	if spawn_side == 0: #x
		var y := randi_range(0,1) #0: y = 350 (bottom), 1: y = -350 (top)
		var x := randi_range(-X_OFFSET, X_OFFSET)
		if y == 0:
			spawn = Vector2(x, Y_OFFSET)
		else:
			spawn = Vector2(x, -Y_OFFSET)
	else: #y
		var x := randi_range(0,1) #0: x = 630 (right), 1: x = -630 (left)
		var y := randi_range(-Y_OFFSET, Y_OFFSET)
		if x == 0:
			spawn = Vector2(X_OFFSET, y)
		else:
			spawn = Vector2(-X_OFFSET, y)
	return spawn

func _on_game_over() -> void:
	timer.stop()
	for child in get_children():
		if child is Zombie:
			child.queue_free()
	
