extends Area2D
class_name Asteroid


var direction: Vector2

@onready var explosion_particles = $PlayerExplosionParticles
@onready var explosion_sound = preload("res://Capstone-Project-Amogh-Mukherjee/Scenes/explosion.tscn")

@onready var utils = get_node("/root/Utilities")
@onready var base_speed = 100
var base_score = 100
var bump_boost = 50
@onready var speed = base_speed * utils.gameSpeedMult
@onready var asteroid_score = scoring_algorithm()
@onready var pause_menu = preload("res://Capstone-Project-Amogh-Mukherjee/Scenes/pause_menu.tscn")
var size : int

signal on_asteroid_destroyed(size: int, position: Vector2)

func _ready() -> void:
	utils.bomb_exploded.connect(on_destroy)
	utils.game_speed_changed.connect(change_speed)
	var x = randf_range(-1,1)
	var y = randf_range(-1,1)
	direction = Vector2(x,y)

func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if (body as Player).is_invincible:
		return
	if (body as Player).is_boosting:
		utils.score_changed.emit(asteroid_score)
		on_destroy(true)
		return
	if body is Player:
		(body as Player).on_player_died.emit()
		body.queue_free()
		on_destroy()

func emit_explosion():
	explosion_particles.emitting = true
	explosion_particles.reparent(get_tree().root)

func on_destroy(counts_for_score: bool = false):
	emit_explosion()
	utils.play_explosion.emit()
	var new_size = (size + 1) % 3
	if new_size == 0:
		new_size = 3
	on_asteroid_destroyed.emit(new_size, global_position)
	if counts_for_score:
		utils.score_changed.emit(asteroid_score)

	queue_free()

func scoring_algorithm() -> float:
	var new_score = base_score * size
	return new_score

func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		if !(area as Bullet).IsItUFO:
				utils.score_changed.emit(asteroid_score)
				on_destroy()
		area.queue_free()
		on_destroy(false)


func change_speed(new_speed: float):
	speed = base_speed * new_speed


func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area is Asteroid or area is UFO:
		direction *= -1
