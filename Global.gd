extends Node

func _input(event:InputEvent):
	if event.is_action_released("fullscreen_toggle"):
		OS.window_fullscreen = !OS.window_fullscreen
