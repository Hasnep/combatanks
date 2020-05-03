extends "res://Tank/Tank.gd"


# Getter functions for constants
func get_max_movement_speed() -> float:
	return 10.0


func get_max_angular_velocity() -> float:
	return 0.1


func get_colour() -> Color:
	var player_colours = ["#ff4949", "#f9f251", "#1af66c", "#3644ff", "#cb3cfd"]
	randomize()
	return Color(player_colours[randi() % len(player_colours)])


# Getter functions for actions
func get_desired_base_velocity() -> Vector2:
	var desired_z: int = 0
	var desired_x: int = 0

	if Input.is_action_pressed("move_up"):
		desired_z -= 1
	if Input.is_action_pressed("move_down"):
		desired_z += 1
	if Input.is_action_pressed("move_left"):
		desired_x -= 1
	if Input.is_action_pressed("move_right"):
		desired_x += 1

	return Vector2(desired_x, desired_z)


onready var mouse_marker: MeshInstance = get_node("/root/World/MouseMarker")


func get_desired_turret_rotation() -> float:
	var mouse_position_2d: Vector2 = Global.three_to_two(mouse_marker.transform.origin)
	var tank_position_2d: Vector2 = Global.three_to_two(transform.origin)
	return (mouse_position_2d - tank_position_2d).angle_to(Vector2(0, 1))


func get_shoot_action() -> bool:
	return Input.is_action_just_pressed("shoot")


func get_lay_mine_action() -> bool:
	return Input.is_action_just_pressed("mine")
