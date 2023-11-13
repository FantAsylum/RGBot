extends Node2D

# TODO: allow enter only one time?
# TODO: blend colors of bot and barrier?
signal barrier_is_entered(color_number: int)


@onready var sprite = $Sprite

var color_numbers: Array[int] 

func _ready():
	color_numbers = [0, 1, 2]
	color_numbers.shuffle()
	
	sprite.material = sprite.material.duplicate(true)
	sprite.material.set_shader_parameter("firstColor", ColorManager.color_by_number[color_numbers[0]])
	sprite.material.set_shader_parameter("secondColor", ColorManager.color_by_number[color_numbers[1]])
	sprite.material.set_shader_parameter("thirdColor", ColorManager.color_by_number[color_numbers[2]])


func _on_first_color_body_entered(body):
	emit_signal("barrier_is_entered", color_numbers[0])


func _on_second_color_body_entered(body):
	emit_signal("barrier_is_entered", color_numbers[1])


func _on_third_color_body_entered(body):
	emit_signal("barrier_is_entered", color_numbers[2])
