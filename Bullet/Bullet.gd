extends KinematicBody

const BULLET_SPEED: float = 10.0
const BARREL_LENGTH: float = 1.8
const TURRRET_HEIGHT: float = 1.5


func constructor(parent: KinematicBody, turret_position: Vector3, direction: Vector3):
	add_collision_exception_with(parent)  # Don't collide with parent
	rotation = direction
	transform.origin = (
		turret_position
		+ Vector3(0, TURRRET_HEIGHT, 0)
		+ BARREL_LENGTH * transform.basis.z
	)


func _physics_process(_delta: float):
	move_and_slide(BULLET_SPEED * global_transform.basis.z)
