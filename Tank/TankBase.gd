extends KinematicBody

var Mine = preload("res://Mine/Mine.tscn")

onready var tank: Spatial = $"../Tank"
onready var mine_container: Node = $"../../Mines"

const max_speed: float = 10.0
const max_angular_velocity: float = 0.1

var speed: float = 0.0


func _physics_process(_delta: float):
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

	if desired_x == 0 and desired_z == 0:
		speed = 0
	else:
		var facing: Vector2 = Vector2(
			global_transform.basis.z.x, global_transform.basis.z.z
		)
		var direction_delta: float = Vector2(desired_x, desired_z).angle_to(facing)

		# Limit rotation speed
		direction_delta = min(direction_delta, max_angular_velocity)
		direction_delta = max(direction_delta, -max_angular_velocity)

		# Snap to direction
		if abs(direction_delta) < 0.001:
			direction_delta = 0

		rotation += Vector3(0, direction_delta, 0)
		speed = max_speed

	# Move tank
	move_and_slide(speed * global_transform.basis.z)

	if Input.is_action_just_pressed("mine"):
		lay_mine()


func lay_mine():
	var m = Mine.instance()
	m.constructor(transform.origin)
	mine_container.add_child(m)
