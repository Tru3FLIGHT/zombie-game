extends ProgressBar

var Health: int
var Health_max: int

@onready var player: PlayerCharacter = $".."

func _ready() -> void:
	Health_max = player.Health
	Health = Health_max
	max_value = Health_max
	value = Health

func _on_player_health_changed() -> void:
	Health = player.Health
	value = Health
