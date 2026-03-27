extends Node
class_name LevelManager

signal player_life_lost(lives_left: int)

const player_start_position = Vector2(960,540)
@export var lives = 3


var player_scene = preload("res://Capstone-Project-Amogh-Mukherjee/Scenes/player.tscn")
@onready var player = $"../Player" as Player

func _ready() -> void:
	player.on_player_died.connect(decrease_lives)

func decrease_lives():
	lives -= 1;
	if lives != 0:
		var new_player = player_scene.instantiate() as Player
		new_player.on_player_died.connect(decrease_lives)
		call_deferred("respawn",new_player)
	else:
		game_over()


func respawn(player: Player):
	get_tree().root.get_node("Level").add_child(player)
	player.global_position = player_start_position
	player.start_invincibility()

func game_over():
	print("Game Over!")
