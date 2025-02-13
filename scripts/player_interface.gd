class_name player_interfce
extends input_interface

func get_movement_direction() -> Vector2:
    return Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down") 

func attack_input() -> bool:
    if Input.is_action_just_pressed("shoot"): return true
    else: return false

func handle_anims() -> String:
    return ""