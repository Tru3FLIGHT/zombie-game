extends Node

@onready var player: PlayerCharacter = $player
@onready var pickups: Node = $pickups

@warning_ignore("unused_signal")
signal game_over

const GAME_OVER = preload("res://scenes/game_over.tscn")

@onready var difficulty_timer: Timer = $difficulty_timer
@onready var game_timer: Timer = $game_timer
@onready var game_over_screen: Timer = $game_over
@onready var game_over_container: Control = $Camera2D/game_over_container
@onready var fps_count: Label = $Camera2D/game_over_container/fps_count

@export
var difficulty: float = 1.0

var score: int = 0

#this script will mainly be used to connect scripts lower in the tree

func _ready() -> void:
	print(difficulty)
	pass

func _on_ammo_pickup(amount:int) -> void:
	player.ammo += amount

func _on_first_aid_pickup(amount:int) -> void:
	player.Health += amount

func _process(delta: float) -> void:
	fps_count.text = str(round(1/delta))

func _on_med_kit_pickup(amount:int) -> void:
	player.Health += amount

func _on_player_death() -> void:
	print(score)
	game_timer.stop()
	emit_signal("game_over")
	game_over_screen.start()

func _on_score(earned:int) -> void:
	score += earned

func _on_shotgun_ammo_pickup(amount:int) -> void:
	player.shotgun_ammo += amount

func _on_difficulty_timer_timeout() -> void:
	difficulty += 1.0
	print(difficulty)

func _on_game_timer_timeout() -> void:
	@warning_ignore("narrowing_conversion")
	score += 1 * difficulty


func _on_game_over_timeout() -> void:
	print("new game over screen")
	var screen = GAME_OVER.instantiate()
	screen.player_score = score
	game_over_container.add_child(screen)
