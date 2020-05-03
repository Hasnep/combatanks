extends Node


func _input(event: InputEvent):
	if event.is_action_released("fullscreen_toggle"):
		OS.window_fullscreen = ! OS.window_fullscreen
	if event.is_action_released("quit_game"):
		get_tree().quit()


func two_to_three(v: Vector2) -> Vector3:
	return Vector3(v.x, 0, v.y)


func three_to_two(v: Vector3) -> Vector2:
	return Vector2(v.x, v.z)
