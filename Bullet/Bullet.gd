extends KinematicBody

const BULLET_SPEED: float = 10.0
const BARREL_LENGTH: float = 1.8

func _physics_process(delta: float):
	move_and_slide(BULLET_SPEED * global_transform.basis.z)

func constructor(parent: KinematicBody, turret_position: Vector3, direction: Vector3):
	add_collision_exception_with(parent)  # Don't collide with parent
	rotation = direction
	turret_position += Vector3(0, 1.5, 0)  # Add turret height
	turret_position += BARREL_LENGTH * transform.basis.z  # Add barrel length
	transform.origin = turret_position
