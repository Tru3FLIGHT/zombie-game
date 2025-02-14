extends State

@onready var reset_game: Timer = $Reset_game

func enter()-> void:
	super()
	reset_game.start()

func _on_reset_game_timeout() -> void:
	get_tree().reload_current_scene()
