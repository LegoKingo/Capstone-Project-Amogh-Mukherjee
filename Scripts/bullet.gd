extends Area2D
class_name Bullet

var direction : Vector2
@export var bullet_speed = 700
var IsItUFO : bool = false
@onready var sprite2D = $Sprite2D
@onready var ufo_bullet_sprite = preload("res://Capstone-Project-Amogh-Mukherjee/Assets/UFO_bullet.png")
@onready var normal_sprite = preload("res://Capstone-Project-Amogh-Mukherjee/Assets/bullet.png")

func _ready():
	if IsItUFO == true:
		sprite2D.texture = ufo_bullet_sprite
	else:
		sprite2D.texture = normal_sprite

func _process(delta: float) -> void:
	position += direction * bullet_speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
