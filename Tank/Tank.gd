extends KinematicBody


# Getter functions for constants
func get_max_movement_speed() -> float:
	return 0.0


func get_max_angular_velocity() -> float:
	return 0.0


func get_max_bullets() -> int:
	return 0


func get_colour() -> Color:
	return Color(0, 0, 0)


# Getter functions for actions
func get_desired_base_velocity() -> Vector2:
	return Vector2(0, 0)


func get_desired_turret_rotation() -> float:
	return 0.0


func get_shoot_action() -> bool:
	return false


func get_lay_mine_action() -> bool:
	return false


var max_speed: float = get_max_movement_speed()
var max_angular_velocity: float = get_max_angular_velocity()
var max_bullets: int = get_max_bullets()

var speed: float = 0.0
var n_bullets: int = 0


func _ready():
	var my_colour: Color = get_colour()
	$"TankTurret".material_override.albedo_color = my_colour
	$"TankBase".material_override.albedo_color = my_colour


func _physics_process(_delta: float):
	var desired_velocity: Vector2 = get_desired_base_velocity()

	if desired_velocity == Vector2(0, 0):
		speed = 0
	else:
		speed = max_speed

		var current_direction: Vector2 = Global.three_to_two(global_transform.basis.z)
		var direction_delta: float = desired_velocity.angle_to(current_direction)

		# Limit rotation speed
		direction_delta = min(direction_delta, max_angular_velocity)
		direction_delta = max(direction_delta, -max_angular_velocity)

		# Snap to direction
		if abs(direction_delta) < 0.001:
			direction_delta = 0

		rotation += Vector3(0, direction_delta, 0)

	# Move tank
	move_and_slide(speed * global_transform.basis.z)


onready var turret = $"TankTurret"


func _process(_delta: float):
	turret.rotation = -rotation + Vector3(0, get_desired_turret_rotation(), 0)

	if get_shoot_action():
		_shoot()

	if get_lay_mine_action():
		_lay_mine()


var Mine = preload("res://Mine/Mine.tscn")
onready var mine_container: Node = get_node("/root/World/Mines")


func _lay_mine():
	var m = Mine.instance()
	m._constructor(self, transform.origin)
	mine_container.add_child(m)


var Bullet = preload("res://Bullet/Bullet.tscn")
onready var bullet_container: Node = get_node("/root/World/Bullets")


func _shoot():
	if n_bullets < max_bullets:
		var b = Bullet.instance()
		b._constructor(self, transform.origin, turret.global_transform.basis.get_euler())
		bullet_container.add_child(b)
		n_bullets += 1


func _on_bullet_removed():
	n_bullets -= 1
