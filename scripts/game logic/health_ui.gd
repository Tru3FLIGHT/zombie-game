extends ProgressBar

var Health: int
var Health_max: int

@onready var player: PlayerCharacter = $".."

func _ready() -> void:
	player.connect("health_changed", Callable(self, "health_changed"))
	Health_max = player.Health
	Health = Health_max
	max_value = Health_max
	value = Health

func health_changed() -> void:
	Health = player.Health
	value = Health
