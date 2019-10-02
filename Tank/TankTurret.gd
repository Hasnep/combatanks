extends MeshInstance

onready var mouse_marker: MeshInstance = $"../MouseMarker"

func process(delta: float):
	# Make turret face mouse
	var mouse_position_2d: Vector2 = Vector2(mouse_marker.transform.origin.x, mouse_marker.transform.origin.z)
	var tank_position_2d: Vector2 = Vector2(transform.origin.x, transform.origin.z)
	var turret_angle: float = (mouse_position_2d - tank_position_2d).angle_to(Vector2(0, 1))
	rotation = Vector3(0, turret_angle, 0)
