extends Node2D

@onready var sprite = $Sprite

var color_numbers: Array[int] 

func _ready():
	color_numbers = [0, 1, 2]
	color_numbers.shuffle()
	print(color_numbers)
	
	sprite.material = sprite.material.duplicate(true)
	sprite.material.set_shader_parameter("firstColor", ColorManager.color_by_number[color_numbers[0]])
	sprite.material.set_shader_parameter("secondColor", ColorManager.color_by_number[color_numbers[1]])
	sprite.material.set_shader_parameter("thirdColor", ColorManager.color_by_number[color_numbers[2]])
