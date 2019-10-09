extends KinematicBody

const speed: float = 10.0

func _physics_process(delta: float):
	move_and_slide(speed * global_transform.basis.z)

func constructor(parent: KinematicBody, turret_position: Vector3, direction: Vector3):
	add_collision_exception_with(parent) # don't collide with parent
	rotation = direction
	transform.origin = turret_position + \
	Vector3(0,1.5,0) + \ # add turret height
	Vector3()