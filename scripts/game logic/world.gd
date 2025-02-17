extends Node

@onready var player: PlayerCharacter = $player
@onready var pickups: Node = $pickups

#this script will mainly be used to connect scripts lower in the tree

func _ready() -> void:
	pass

func _on_ammo_pickup(amount:int) -> void:
	player.ammo += amount
