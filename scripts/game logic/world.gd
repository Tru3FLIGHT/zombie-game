extends Node

@onready var player: PlayerCharacter = $player
@onready var pickups: Node = $pickups

@warning_ignore("unused_signal")
signal game_over

#this script will mainly be used to connect scripts lower in the tree

func _ready() -> void:
	pass

func _on_ammo_pickup(amount:int) -> void:
	player.ammo += amount

func _on_first_aid_pickup(amount:int) -> void:
	player.Health += amount

func _on_player_death() -> void:
	emit_signal("game_over")
