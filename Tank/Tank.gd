extends KinematicBody

onready var tank_base: MeshInstance = $"TankBase"
onready var tank_turret: MeshInstance = $"TankTurret"
onready var mouse_marker: MeshInstance = $"../MouseMarker"

const max_speed: float = 10.0
const base_max_angular_velocity: float = 0.1

var speed: float = 0.0

func _physics_process(delta: float):
	var base_desired_z: int = 0
	var base_desired_x: int = 0

	if Input.is_action_pressed("move_up"):
		base_desired_z -= 1
	if Input.is_action_pressed("move_down"):
		base_desired_z += 1
	if Input.is_action_pressed("move_left"):
		base_desired_x -= 1
	if Input.is_action_pressed("move_right"):
		base_desired_x += 1

	if base_desired_x == 0 and base_desired_z == 0:
		speed = 0
	else:
		var base_facing: Vector2 = Vector2(tank_base.global_transform.basis.z.x, tank_base.global_transform.basis.z.z)
		var base_direction_delta: float = Vector2(base_desired_x, base_desired_z).angle_to(base_facing)
		
		# Limit rotation speed
		base_direction_delta = min(base_direction_delta, base_max_angular_velocity)
		base_direction_delta = max(base_direction_delta, -base_max_angular_velocity)
		
		# Snap to direction
		if abs(base_direction_delta) < 0.001:
			base_direction_delta = 0
		
		tank_base.rotation += Vector3(0, base_direction_delta, 0)
		speed = max_speed
	
	# Move tank
	var linear_velocity = move_and_slide(speed * tank_base.global_transform.basis.z)
	
	# Make turret face mouse
	var mouse_position_2d: Vector2 = Vector2(mouse_marker.transform.origin.x, mouse_marker.transform.origin.z)
	var tank_position_2d: Vector2 = Vector2(transform.origin.x, transform.origin.z)
	var turret_angle: float = (mouse_position_2d - tank_position_2d).angle_to(Vector2(0, 1))
	tank_turret.rotation = Vector3(0, turret_angle, 0)
