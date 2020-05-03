extends KinematicBody

const BULLET_SPEED: float = 0.1
const BARREL_LENGTH: float = 1.8
const TURRRET_HEIGHT: float = 1.5

var velocity: Vector3




func constructor(parent: KinematicBody, turret_position: Vector3, direction: Vector3):
	add_collision_exception_with(parent)  # Don't collide with parent
	rotation = direction
	velocity = BULLET_SPEED * transform.basis.z
	transform.origin = (
		turret_position
		+ Vector3(0, TURRRET_HEIGHT, 0)
		+ BARREL_LENGTH * transform.basis.z
	)


func _collide_wall(collision: KinematicCollision):
	var collision_normal: Vector3 = collision.normal
	var collision_normal_2d: Vector2 = Global.three_to_two(collision_normal)
	# Calculate the remaining motion after colliding
	var remaining_motion_2d: Vector2 = Global.three_to_two(collision.remainder).bounce(
		collision_normal_2d
	)
	var remaining_motion_3d: Vector3 = Global.two_to_three(remaining_motion_2d)
	# Calculate new velocity after colliding
	var velocity_2d: Vector2 = Global.three_to_two(velocity)
	velocity_2d = velocity_2d.bounce(collision_normal_2d)
	velocity = Global.two_to_three(velocity_2d)
	# Rotate to face new direction
	look_at(global_transform.origin - velocity, Vector3(0, 1, 0))
	# Finish travelling remaining distance
	move_and_collide(remaining_motion_3d)


func _physics_process(_delta: float):
	var collision = move_and_collide(velocity)
	if collision:
		match collision.collider.name:
			"Bullet":
				pass
			"Wall":
				_collide_wall(collision)
			"Tank":
				pass
