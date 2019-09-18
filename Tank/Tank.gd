extends KinematicBody

const max_speed: float = 20.0
const acceleration: float = 10.0

var direction: float = 0.0
var velocity: Vector3 = Vector3()

func _physics_process(delta: float):

	var input_forward: float = 0.0
	var input_rotation: float = 0.0

	if Input.is_action_pressed("move_forward"):
		input_forward += 1
	if Input.is_action_pressed("move_backward"):
		input_forward -= 1
	if Input.is_action_pressed("turn_left"):
		input_rotation -= 1
	if Input.is_action_pressed("turn_right"):
		input_rotation += 1

	rotation_degrees += Vector3(input_rotation, 0, 0)
	move_and_slide(Vector3(input_forward, 0, 0), Vector3(0, 0, 0))
