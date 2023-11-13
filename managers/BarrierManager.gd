extends Node2D

signal barrier_is_entered(color_number: int)

@export var barrier_scene: PackedScene = preload("res://objects/barrier.tscn")

@export var barrier_count = 5

@onready var current_barrier_position = $CurrentBarrierPosition
@onready var next_barrier_position = $NextBarrierPosition

var distance_between: float
var barriers: Array[Node2D]

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
	
	instance.connect("barrier_is_entered", 
					 func(barrier, color_number):
						if barrier == barriers[barrier_count / 2]:
							spawn_barrier()
						emit_signal("barrier_is_entered", color_number))
	
	if len(barriers) == barrier_count:
		barriers[0].queue_free()
		barriers.remove_at(0)
	
	barriers.push_back(instance)
