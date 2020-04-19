extends Spatial


func _ready():
	var tank_colours_string = ["#ff4949", "#f9f251", "#1af66c", "#3644ff", "#cb3cfd"]
	var tank_colours = []
	for s in tank_colours_string:
		tank_colours.append(Color(s))
	randomize()
	var my_colour = tank_colours[randi() % len(tank_colours)]
	$"TankTurret".material_override.albedo_color = my_colour
