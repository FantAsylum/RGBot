extends Node2D

@export var barrier_scene: PackedScene = preload("res://objects/barrier.tscn")

@export var barrier_count = 5

@onready var current_barrier_position = $CurrentBarrierPosition
@onready var next_barrier_position = $NextBarrierPosition

var distance_between: float

func _ready():
	distance_between = next_barrier_position.position.x - current_barrier_position.position.x
	for i in range(barrier_count):
		spawn_barrier()
	

func spawn_barrier():
	var instance = barrier_scene.instantiate()
	add_child(instance)
	
	instance.position = current_barrier_position.position
	current_barrier_position.position = next_barrier_position.position
	next_barrier_position.position.x += distance_between
