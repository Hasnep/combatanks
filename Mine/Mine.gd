extends Spatial

var MineExplosion: Resource = load("res://Mine/MineExplosion.tscn")

func constructor(tank_position: Vector3):
	transform.origin = tank_position

func _on_timer_timeout():
	var e = MineExplosion.instance()
	get_parent().add_child(e)
	e.transform.origin = self.transform.origin
	self.queue_free()
