extends CharacterBody2D

const VELOCITY_MODIFIER = 10.

@onready var sprite: Sprite2D = $Sprite
var top_height: float
var middle_height: float
var bottom_height: float
var base_velocity: float

var rng = RandomNumberGenerator.new()

func _ready():
	sprite.material.set_shader_parameter("bot_color", random_color())
	
	var screen_size = DisplayServer.window_get_size()
	middle_height  = screen_size.y / 2.
	base_velocity  = middle_height / 2.
	top_height     = middle_height - base_velocity
	bottom_height  = middle_height + base_velocity
	

func _process(delta):
	velocity.y = 0
	if (Input.is_action_pressed("move_up")):
		velocity.y -= base_velocity * VELOCITY_MODIFIER

	if (Input.is_action_pressed("move_down")):
		velocity.y += base_velocity * VELOCITY_MODIFIER
	
	# TODO: make it smoother
	if (velocity.y < 0 and global_position.y <= top_height):
		velocity.y = 0
	if (velocity.y > 0 and global_position.y >= bottom_height):
		velocity.y = 0
	
	if  (velocity.y == 0):
		var diff = middle_height - global_position.y
		if (diff > base_velocity / 5.):
			velocity.y = sign(diff) * base_velocity * VELOCITY_MODIFIER
		else:
			velocity.y = diff * VELOCITY_MODIFIER
	
	move_and_slide()

func random_color():
	var color
	match (rng.randi() % 3):
		0:
			return Color.RED
		1:
			return Color.GREEN
		2:
			return Color.BLUE
