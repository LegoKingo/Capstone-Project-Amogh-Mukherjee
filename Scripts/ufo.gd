extends Area2D
class_name UFO

@onready var explosion_particles = $PlayerExplosionParticles
@onready var shooting_timer = $ShootingTimer

@export var ufo_bullet_scene : PackedScene
var path : PathFollow2D

var speed = 500
var current_point_on_path = 0

func _ready() -> void:
	shooting_timer.timeout.connect(shoot)

func _process(delta: float) -> void:
	if path == null:
		return
	var progress = delta * speed
	path.progress += progress


func shoot():
	var bullet = ufo_bullet_scene.instantiate() as Bullet
	bullet.IsItUFO = true
	bullet.set_collision_layer_value(2, 0)
	bullet.set_collision_layer_value(5,1)
	
	get_tree().root.add_child(bullet)
	bullet.position = global_position
	bullet.direction = targeting_algorithm()
	bullet.bullet_speed = 100


func targeting_algorithm() -> Vector2:
	var node_y = get_global_transform().origin.y
	var screen_height = get_viewport().get_visible_rect().size.y
	
	var should_shoot_down = node_y <= screen_height / 2
	
	if should_shoot_down:
		var angle = deg_to_rad(randf_range(45,135))
		return Vector2(cos(angle), sin(angle))
	else:
		var angle = deg_to_rad(randf_range(225,315))
		return Vector2(cos(angle), sin(angle))

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet && area.collision_layer == 2:
		area.queue_free()
		queue_free()
		explosion_particles.emitting = true
		explosion_particles.reparent(get_tree().root)
