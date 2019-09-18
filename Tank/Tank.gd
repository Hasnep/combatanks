extends KinematicBody

const max_speed: float = 1.0
const acceleration: float = 0.01

var direction: float = 0.0
var velocity: Vector3 = Vector3()
var speed: float = 0.0

func _physics_process(delta: float):
	var input_forward: float = 0.0
	var input_rotation: float = 0.0

	if Input.is_action_pressed("move_forward"):
		if speed < max_speed:
			speed += acceleration
	else:
		speed /= 2
	if Input.is_action_pressed("move_backward"):
		speed -= acceleration
	if Input.is_action_pressed("turn_left"):
		input_rotation += 1
	if Input.is_action_pressed("turn_right"):
		input_rotation -= 1

	rotation_degrees += Vector3(0, input_rotation, 0)
	move_and_slide(speed * global_transform.basis.z)
