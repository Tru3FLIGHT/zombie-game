extends Node

@onready var player: PlayerCharacter = $player
@onready var pickups: Node = $pickups

@warning_ignore("unused_signal")
signal game_over

@onready var difficulty_timer: Timer = $difficulty_timer
@onready var game_timer: Timer = $game_timer

@export
var difficulty: float = 1.0

var score: int = 0

#this script will mainly be used to connect scripts lower in the tree

func _ready() -> void:
	pass

func _on_ammo_pickup(amount:int) -> void:
	player.ammo += amount

func _on_first_aid_pickup(amount:int) -> void:
	player.Health += amount

func _on_med_kit_pickup(amount:int) -> void:
	player.Health += amount

func _on_player_death() -> void:
	print(score)
	emit_signal("game_over")

func _on_score(earned:int) -> void:
	print(earned)
	score += earned

func _on_difficulty_timer_timeout() -> void:
	difficulty += 1.0

func _on_game_timer_timeout() -> void:
	score += 1 * difficulty
