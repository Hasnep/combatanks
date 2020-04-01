extends Camera

onready var mouse_marker = $"../MouseMarker"
onready var cursor = $"GUI/Cursor"
onready var debug_info = $"GUI/DebugInfo"

var floor_plane: Plane = Plane(Vector3(0, 1, 0), 0)


func _process(_delta: float):
	# Find cursor position in world
	var mouse_viewport: Vector2 = get_viewport().get_mouse_position()
	var mouse_world: Vector3 = floor_plane.intersects_ray(
		project_ray_origin(mouse_viewport), project_ray_normal(mouse_viewport)
	)
	mouse_marker.transform.origin = mouse_world
	cursor.position = mouse_viewport

	# Change debug text
	if debug_info.visible:
		debug_info.set_text("FPS: " + str(Engine.get_frames_per_second()))


func _input(event):
	# Toggle debug info
	if event.is_action_released("debug_info_toggle"):
		debug_info.visible = ! debug_info.visible
