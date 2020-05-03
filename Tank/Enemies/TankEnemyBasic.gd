extends "res://Tank/Tank.gd"


# Getter functions for constants
func get_max_movement_speed() -> float:
	return 0.0


func get_max_angular_velocity() -> float:
	return 0.0


func get_colour() -> Color:
	return Color(1, 0, 0)


# Function overriding
var timer_shoot


func _ready():
	._ready()
	timer_shoot = Timer.new()
	timer_shoot.connect("timeout", self, "_on_timer_shoot")
	add_child(timer_shoot)
	timer_shoot.wait_time = 2
	timer_shoot.start()


var shoot = false


func _on_timer_shoot():
	shoot = true


# Getter functions for actions
func get_desired_base_velocity() -> Vector2:
	return Vector2(0, 0)


var turret_rotation: float = 0.0
const max_turret_angular_velocity: float = 0.1


func get_desired_turret_rotation() -> float:
	turret_rotation += max_turret_angular_velocity
	turret_rotation = fmod(turret_rotation, 2 * PI)
	return turret_rotation


func get_shoot_action() -> bool:
	if shoot:
		shoot = false
		return true
	else:
		return false


func get_lay_mine_action() -> bool:
	return Input.is_action_just_pressed("mine")
