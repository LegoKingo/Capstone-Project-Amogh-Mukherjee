extends Area2D
class_name Asteroid

@export var speed = 100
var direction: Vector2

@onready var explosion_particles = $PlayerExplosionParticles

func _ready() -> void:
	var x = randf_range(-1,1)
	var y = randf_range(-1,1)
	direction = Vector2(x,y)

func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.queue_free()
		on_destroy()

func emit_explosion():
	explosion_particles.emitting = true
	explosion_particles.reparent(get_tree().root)

func on_destroy():
	emit_explosion()
	queue_free()
