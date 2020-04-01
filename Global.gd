extends Node

func _input(event:InputEvent):
	if event.is_action_pressed("fullscreen_toggle"):
		OS.window_fullscreen = !OS.window_fullscreen
	if event.is_action_released("quit_game"):
		get_tree().quit()
