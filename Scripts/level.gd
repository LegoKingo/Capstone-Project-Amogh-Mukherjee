extends Node2D

@onready var utils = get_node("/root/Utilities")

func _ready() -> void:
	utils.end_of_game.connect(end_level)


func end_level():
	if is_inside_tree():
		for object in get_tree().get_nodes_in_group("game_objects"):
			object.queue_free()
		for object in get_tree().get_nodes_in_group("Asteroids"):
			object.queue_free()
	if utils.game_over:
		get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/game_over.tscn")
	else:
		get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/level_summary.tscn")
