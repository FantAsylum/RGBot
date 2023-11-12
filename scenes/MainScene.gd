extends Node2D

@onready var bot: Bot = $Bot
@onready var camera: Camera2D = $Camera

var distance_between_bot_and_camera: float

func _ready():
	distance_between_bot_and_camera = camera.position.x - bot.position.x

func _process(delta):
	camera.position.x = bot.position.x + distance_between_bot_and_camera
