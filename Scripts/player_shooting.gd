extends Node2D

var bullet_scene = preload("res://Capstone-Project-Amogh-Mukherjee/Scenes/bullet.tscn")
@onready var shoot_sound: AudioStreamPlayer2D = $PlayerShoot
@onready var level = $"../.."

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot_sound.play( )
		var bullet = bullet_scene.instantiate() as Bullet
		bullet.IsItUFO = false
		level.add_child(bullet)
		
		
		var shot_direction = Vector2(0, -1).rotated(get_parent().rotation)
		bullet.position = global_position
		bullet.direction = shot_direction
