extends RayCast2D


func process_physics(facing:int) -> void:
	match facing:
		0:
			set_rotation_degrees(deg_to_rad(90))
		1:
			set_rotation_degrees(deg_to_rad(270))
		2:
			set_rotation_degrees(deg_to_rad(180))
		3:
			set_rotation_degrees(deg_to_rad(0))
