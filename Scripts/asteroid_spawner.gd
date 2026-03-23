extends Node

class_name AsteroidSpawner

@export var large_asteroid_scene : PackedScene
@export var medium_asteroid_scene : PackedScene
@export var small_asteroid_scene : PackedScene

@export var count = 6
@export var spawn_offset_dist = 500

func _ready() -> void:
	for i in range(count):
		var random_spawn_position = get_rand_position()
		spawn_asteroid(1,random_spawn_position)

func get_rand_position() -> Vector2:
	var size : Vector2 = get_viewport().size
	var rand_angle : float = randf_range(0,2 * PI)
	var center = size / 2
	var spawn_offset = Vector2.RIGHT.rotated(rand_angle) * spawn_offset_dist
	var spawn_location = center + spawn_offset
	
	return spawn_location


func spawn_asteroid(asteroid_size: int, spawn_point: Vector2):
	var asteroid
	if asteroid_size == 1:
		asteroid = large_asteroid_scene.instantiate() as Asteroid
	elif asteroid_size == 2:
		asteroid = medium_asteroid_scene.instantiate() as Asteroid
	elif asteroid_size == 3:
		asteroid = small_asteroid_scene.instantiate() as Asteroid
	elif asteroid_size > 3: 
		return
	
	get_tree().root.add_child.call_deferred(asteroid)
	asteroid.global_position = spawn_point
