extends Area2D
class_name Asteroid

@export var speed = 100
var direction: Vector2

@onready var explosion_particles = $PlayerExplosionParticles

const utils = preload("res://Capstone-Project-Amogh-Mukherjee/Scripts/Utilities.gd")

var size : int

signal on_asteroid_destroyed(size: int, position: Vector2)

func _ready() -> void:
	print(size)
	var x = randf_range(-1,1)
	var y = randf_range(-1,1)
	direction = Vector2(x,y)

func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		#body.queue_free()
		on_destroy()

func emit_explosion():
	explosion_particles.emitting = true
	explosion_particles.reparent(get_tree().root)

func on_destroy():
	emit_explosion()
	var new_size = (size + 1) % 3
	if new_size == 0:
		new_size = 3
	on_asteroid_destroyed.emit(new_size, global_position)
	queue_free()



func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		area.queue_free()
		on_destroy()
