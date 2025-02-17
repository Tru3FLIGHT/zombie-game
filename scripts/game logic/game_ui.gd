extends Control

@onready var ammo_count: Label = $"ammo count"
@onready var player: PlayerCharacter = $"../player"

func _ready() -> void:
	player.connect("ammo_changed", Callable(self, "_on_ammo_changed"))
	_on_ammo_changed()


func _on_ammo_changed() -> void:
	print("ammo_change_event")
	ammo_count.text = str(player.ammo)
