extends MeshInstance

var Bullet = preload("res://Bullet/Bullet.tscn")

onready var tank_base: KinematicBody = $"../TankBase"
onready var mouse_marker: MeshInstance = $"../../MouseMarker"
onready var bullet_container: Node = $"../../Bullets"

func _process(delta: float):
	transform.origin = tank_base.transform.origin
	
	# Make turret face mouse
	var mouse_position_2d: Vector2 = Vector2(mouse_marker.transform.origin.x, mouse_marker.transform.origin.z)
	var tank_position_2d: Vector2 = Vector2(transform.origin.x, transform.origin.z)
	var turret_angle: float = (mouse_position_2d - tank_position_2d).angle_to(Vector2(0, 1))
	rotation = Vector3(0, turret_angle, 0)
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var b = Bullet.instance()
	b.constructor(tank_base, transform.origin, rotation)
	bullet_container.add_child(b)
