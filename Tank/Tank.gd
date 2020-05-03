extends KinematicBody


func get_facing_direction() -> float:
	return 0.0


func get_shoot_action() -> bool:
	return false

func get_max_speed() -> float:
	return 0.0


func get_max_angular_velocity() -> float:
	return 0.0


func get_desired_direction() -> Vector2:
	return Vector2(0, 0)


func get_tank_colour() -> Color:
	return Color(0, 0, 0)


func get_lay_mine_action() -> bool:
	return false


var max_speed = get_max_speed()
var max_angular_velocity = get_max_angular_velocity()

var speed: float = 0.0


func _ready():
	var my_colour: Color = get_tank_colour()
	$"TankTurret".material_override.albedo_color = my_colour
	$"TankBase".material_override.albedo_color = my_colour


func _physics_process(_delta: float):
	var desired_direction: Vector2 = get_desired_direction()

	if desired_direction == Vector2(0, 0):
		speed = 0
	else:
		speed = max_speed

		var facing: Vector2 = Vector2(
			global_transform.basis.z.x, global_transform.basis.z.z
		)
		var direction_delta: float = desired_direction.angle_to(facing)

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
	turret.rotation = -rotation + Vector3(0, get_facing_direction(), 0)

	if get_shoot_action():
		_shoot()
		
	if get_lay_mine_action():
		_lay_mine()

var Mine = preload("res://Mine/Mine.tscn")
onready var mine_container: Node = get_node("/root/World/Mines")

func _lay_mine():
	var m = Mine.instance()
	m.constructor(transform.origin)
	mine_container.add_child(m)

var Bullet = preload("res://Bullet/Bullet.tscn")
onready var bullet_container: Node = get_node("/root/World/Bullets")

func _shoot():
	var b = Bullet.instance()
	b.constructor($".", transform.origin, turret.global_transform.basis.get_euler())
	bullet_container.add_child(b)
