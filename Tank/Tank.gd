extends KinematicBody

onready var tank_base: MeshInstance = $"TankBase"
onready var tank_turret: MeshInstance = $"TankTurret"
onready var mouse_marker:MeshInstance = $"../MouseMarker"

const max_speed: float = 10.0
const max_angular_velocity: float = 0.1

var speed: float = 0.0

func _physics_process(delta: float):
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

	var direction_delta: float
	if desired_x == 0 and desired_z == 0:
		speed = 0
	else:
		var facing: Vector2 = Vector2(tank_base.global_transform.basis.z.x, tank_base.global_transform.basis.z.z)
		direction_delta = Vector2(desired_x, desired_z).angle_to(facing)
		
		# Limit rotation speed
		direction_delta = min(direction_delta, max_angular_velocity)
		direction_delta = max(direction_delta, -max_angular_velocity)
		
		# Snap to direction
		if abs(direction_delta) < 0.001:
			direction_delta = 0
			
		tank_base.rotation += Vector3(0, direction_delta, 0)
		speed = max_speed
		
	var linear_velocity = move_and_slide(speed * tank_base.global_transform.basis.z)
	
	var mouse_vector: Vector2 = Vector2(mouse_marker.transform.origin.x,mouse_marker.transform.origin.z)
	var location_vector: Vector2 = Vector2(transform.origin.x, transform.origin.z)
	var desired_vector:Vector2 = location_vector - mouse_vector
	var turret_delta:float = desired_vector.angle_to(Vector2(0,-1))
	tank_turret.rotation = Vector3(0,turret_delta,0)
