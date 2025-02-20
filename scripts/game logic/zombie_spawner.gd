extends spawner
#every time the timer times out a new zombie has a chance to spawn
#the chance of spawning goes up as the difficulty goes up
#specially zombies have a lower chance of spawning, the spawn chance is determined by zombie_rarity_distrobution
#the zombies will spawn at a random location on the edge of the screen
#first we will choose whether to spawn on the x or y axis
#then we will choose a random location on the chosen axis and pick a random side

const zombie_rarity_distrobution = {
	ZOMBIE: 0.70,
	fast_zombie: 0.20,
	strong_zombie: 0.10
	}

@onready 
var timer: Timer = $zombie_timer
@onready 
var target: PlayerCharacter = $"../player"

const ZOMBIE = preload("res://scenes/zombie.tscn")
const fast_zombie = preload("res://scenes/fast_zombie.tscn")
const strong_zombie = preload("res://scenes/strong_zombie.tscn")

@warning_ignore("unused_signal")
signal scored(added:int)

func _ready() -> void:
	timer.wait_time = 1
	timer.start()
	get_parent().connect("game_over", Callable(self, "_on_game_over"))

func _process(delta: float) -> void:
	super(delta)
	



func _on_zombie_timer_timeout() -> void:
	randomize()
	if try_spawn():
		instance_item(zombie_rarity_distrobution, ZOMBIE)

func spawn_item(instance) -> void:
	super(instance)
	instance.target = target

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

func _on_score(add: int) -> void:
	connect("scored", Callable(get_parent(), "_on_score"))
	emit_signal("scored", add)
	disconnect("scored", Callable(get_parent(), "_on_score"))
