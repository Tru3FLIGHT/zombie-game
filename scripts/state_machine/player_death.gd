extends State


@onready var reset_game: Timer = $Reset_game
const GAME_OVER = preload("res://scenes/game_over.tscn")
signal game_over_screen()
const size = Vector2(1280, 719)
const position = Vector2(-640, -360)

func enter()-> void:
	super()
	reset_game.start()

func _on_reset_game_timeout() -> void:
	emit_signal("game_over_screen")
