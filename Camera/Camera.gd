extends Camera

onready var mouse_marker = $"../MouseMarker"
onready var cursor = $"GUI/Cursor"

var floor_plane: Plane = Plane(Vector3(0, 1, 0), 0)

func _process(_delta: float):
	var mouse_viewport: Vector2 = get_viewport().get_mouse_position()
	var mouse_world: Vector3 = floor_plane.intersects_ray(project_ray_origin(mouse_viewport), project_ray_normal(mouse_viewport))
	mouse_marker.transform.origin = mouse_world

	cursor.position = mouse_viewport
