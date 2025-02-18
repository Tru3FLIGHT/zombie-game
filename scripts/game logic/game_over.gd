extends Control

var player_score: int
@onready var score: Label = $score

func _ready() -> void:
	score.text = "Score: %s" % player_score

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_button_2_pressed() -> void:
	get_tree().quit()
