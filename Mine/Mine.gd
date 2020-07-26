extends Spatial

var MineExplosion = preload("res://Mine/MineExplosion.tscn")

var activated = false

var placed_by

const MINE_COUNTDOWN_TIME: float = 9.0
const MINE_DELAY_TIME: float = 1.0


func _constructor(parent: KinematicBody, tank_position: Vector3):
	transform.origin = tank_position
	$MineActivationArea.connect("body_exited", self, "_on_body_leave_activation_area")
	$MineActivationArea.connect("body_entered", self, "_on_body_enter_activation_area")
	placed_by = parent
	$MineCountdown.start(MINE_COUNTDOWN_TIME)


func explode():
	var e = MineExplosion.instance()
	get_parent().add_child(e)
	e.transform.origin = self.transform.origin
	self.queue_free()


func _on_body_leave_activation_area(body):
	if body.is_in_group("tank") and body == placed_by:
		activated = true


func _on_body_enter_activation_area(body):
	if body.is_in_group("bullet"):
		explode()
	elif activated and body.is_in_group("tank"):
		$MineDelay.start(MINE_DELAY_TIME)


func _on_countdown_end():
	$MineDelay.start(MINE_DELAY_TIME)


func _on_delay_end():
	explode()
