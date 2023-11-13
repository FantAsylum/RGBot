extends Node2D

@onready var bot: Bot = $Bot
@onready var camera: Camera2D = $Camera
@onready var colorManager = $ColorManager

var distance_between_bot_and_camera: float

func _ready():
	distance_between_bot_and_camera = camera.position.x - bot.position.x

func _process(delta):
	camera.position.x = bot.position.x + distance_between_bot_and_camera


func _on_barrier_manager_barrier_is_entered(color_number):
	if bot.current_color_number == color_number:
		bot.set_random_color()
	else:
		get_tree().reload_current_scene()
