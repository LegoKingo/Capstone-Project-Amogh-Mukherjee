extends Area2D
class_name Bullet

@onready var utils = get_node("/root/Utilities")
var direction : Vector2
var bullet_base_speed = 700
var ufo_bullet_base_speed = 300
var bullet_speed
var IsItUFO : bool = false
@onready var sprite2D = $Sprite2D
@onready var ufo_bullet_sprite = preload("res://Capstone-Project-Amogh-Mukherjee/Assets/UFO_bullet.png")
@onready var normal_sprite = preload("res://Capstone-Project-Amogh-Mukherjee/Assets/bullet.png")
var loopCounter: int
@onready var rect = get_viewport().size


func _ready():
	utils.game_speed_changed.connect(change_speed)
	utils.bomb_exploded.connect(bomb_destroy)
	
	if IsItUFO == true:
		sprite2D.texture = ufo_bullet_sprite
		bullet_speed = ufo_bullet_base_speed * utils.gameSpeedMult
	else:
		sprite2D.texture = normal_sprite
		bullet_speed = bullet_base_speed
	

func _process(delta: float) -> void:
	position += direction * bullet_speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if utils.loopingBullets && !IsItUFO:
		loopCounter += 1
		position.x = wrapf(position.x, 0, rect.x)
		position.y = wrapf(position.y, 0, rect.y)
		if loopCounter > utils.loopMax:
			utils.bullets_looped += 1
			queue_free()
	else:
		queue_free()

func change_speed(new_speed: float):
	if IsItUFO:
		bullet_speed = ufo_bullet_base_speed * new_speed
	else:
		return

func bomb_destroy(is_bomb: bool):
	if is_bomb:
		queue_free()
