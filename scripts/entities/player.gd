class_name PlayerCharacter
extends Moveable

var ammo: int = 25
var prev_frame_ammo: int = ammo
var prev_frame_health: int = Health
@warning_ignore("unused_signal")
signal ammo_changed
@warning_ignore("unused_signal")
signal health_changed
@warning_ignore("unused_signal")
signal player_death

@onready var health_bar: ProgressBar = $HealthBar
@onready var game_ui: Control = $"Game Ui"

func _ready() -> void:
	super()
	connect("player_death", Callable(get_parent(), "_on_player_death"))

func _process(delta: float) -> void:
	super(delta)
	report_ammo_change()
	report_health_change()

func _on_damage_event(damage: int) -> void:
	take_damage(damage)

func report_ammo_change() -> void:
	if prev_frame_ammo != ammo:
		emit_signal("ammo_changed")
		prev_frame_ammo = ammo

func report_health_change() -> void:
	if prev_frame_health != Health:
		emit_signal("health_changed")
		prev_frame_health = Health

func death_check() -> void:
	if Health <= 0:
		emit_signal("player_death")
		health_bar.queue_free()
		game_ui.queue_free()
	super()

func take_damage(damage: int) -> void:
	Health -= damage
	death_check()
