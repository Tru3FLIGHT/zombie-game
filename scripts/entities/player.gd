class_name PlayerCharacter
extends Moveable

var ammo: int = 25
var prev_frame_ammo: int = ammo
var prev_frame_health: int = Health

signal ammo_changed
signal health_changed
signal player_death

@onready var health_bar: ProgressBar = $HealthBar

func _ready() -> void:
	super()
	connect("player_death", Callable(get_parent(), "_on_player_death"))

func _process(delta: float) -> void:
	super(delta)
	report_ammo_change()
	report_health_change()

func _on_area_entered(area: Area2D) -> void:
	var attacker := area.get_parent()
	if attacker is Zombie:
		Health -= attacker.damage
		death_check()
		return

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
	super()
