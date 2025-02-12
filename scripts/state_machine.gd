extends Node

@onready var move: Node = $move
@export
var starting_state: State

var current_state: State

#initialize, we give the children references to the parent/root node, this is normally poor
#implomentation but the nodes act as indivisual player scripts so we allow it in this instance
func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent
		
	#init default state
	change_state(starting_state)

func change_state(new_state: State) -> void:
	#change the state by first calling exit logic on the state, then calling enter logic on new state
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()
	
func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)
#passthrough functions for the player to call, handling state change as needed
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
		
func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
		
func get_direction() -> Vector2:
	return move.direction
