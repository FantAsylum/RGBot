extends Sprite2D

var rng = RandomNumberGenerator.new()

func _ready():
	material.set_shader_parameter("bot_color", random_color())
	
func random_color():
	var color
	match (rng.randi() % 3):
		0:
			return Color.RED
		1:
			return Color.GREEN
		2:
			return Color.BLUE
