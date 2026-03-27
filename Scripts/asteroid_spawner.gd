extends Node

class_name AsteroidSpawner

@export var large_asteroid_scene : PackedScene
@export var medium_asteroid_scene : PackedScene
@export var small_asteroid_scene : PackedScene

@export var count = 5
@export var spawn_offset_dist = 500

func _ready() -> void:
	for i in range(1, count):
		var size = i % 3
		if size == 0:
			size = 3
		var random_spawn_point = get_rand_position()
		spawn_asteroid(size, random_spawn_point)
		pass

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
	else:
		return
	
	asteroid.size = asteroid_size
	get_tree().root.add_child.call_deferred(asteroid)
	asteroid.global_position = spawn_point
	asteroid.on_asteroid_destroyed.connect(asteroid_destroyed)

func asteroid_destroyed(new_size: int, position: Vector2):
	if new_size == 2 or new_size == 3:
		for i in range(2):
			spawn_asteroid(new_size, position)
	else:
		#No-Need-To-Spawn
		return
