extends Spatial

onready var MineExplosionTween: Tween = $"MineExplosionTween"
onready var MineExplosionParticles: Particles = $"MineExplosionParticles"
onready var MineExplosionLight: Light = $"MineExplosionLight"
onready var MineExplosionModel: MeshInstance = $"MineExplosionModel"

const EXPLOSION_DURATION: float = 1.0


func _ready():
	# Grow explosion sphere
	MineExplosionTween.interpolate_property(
		MineExplosionModel,
		"scale",
		Vector3(1, 1, 1),
		Vector3(3, 3, 3),
		0.5 * EXPLOSION_DURATION,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT
	)
	# Rotate explosion
	MineExplosionTween.interpolate_property(
		MineExplosionModel,
		"rotation_degrees",
		Vector3(0, 0, 0),
		Vector3(0, 90, 0),
		EXPLOSION_DURATION,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	# Move time forwards for explosion animaiton
	MineExplosionTween.interpolate_property(
		MineExplosionModel.get_surface_material(0),
		"shader_param/my_time",
		0,
		1,
		EXPLOSION_DURATION,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	# Decrease light intensity over time
	MineExplosionTween.interpolate_property(
		MineExplosionLight,
		"light_energy",
		100,
		0,
		0.5 * EXPLOSION_DURATION,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT
	)
	MineExplosionTween.start()
	# Emit particles
	MineExplosionParticles.emitting = true


func _on_explosion_tweens_completed():
	self.queue_free()
