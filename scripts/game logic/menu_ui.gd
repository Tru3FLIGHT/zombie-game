extends Control
@onready var menu_camera: Camera2D = $"../Camera2D"

const WORLD = preload("res://scenes/world.tscn")
var difficulty: int = 1

@onready var settings_container: VBoxContainer = $BoxContainer/VBoxContainer2


func _ready() -> void:
	label.text = diff_text % difficulty
	

func _on_start_game_pressed() -> void:
	var world = WORLD.instantiate()
	world.difficulty = difficulty
	get_parent().add_child(world)
	menu_camera.queue_free()
	queue_free()

func _on_options_pressed() -> void:
	if settings_container.visible:
		settings_container.visible = false
	else:
		settings_container.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()


#==== Settings Page ====
var diff_text: String = "Difficulty: %s"

@onready var label: Label = $BoxContainer/VBoxContainer2/Label


func _on_h_slider_value_changed(value: float) -> void:
	@warning_ignore("narrowing_conversion")
	difficulty = value
	label.text = diff_text % difficulty
