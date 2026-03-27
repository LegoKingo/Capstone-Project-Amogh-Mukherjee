extends Control

@onready var player_cam = get_parent().get_parent()
@onready var regular_menu = get_node("MarginContainer/RegularMenu")
@onready var accessibility = get_node("MarginContainer/Accessibility")
@onready var utils = get_node("/root/Utilities")

@onready var current_theme = get_tree().root.theme

var dyslexia_mode = false

func _ready() -> void:
	if utils.dyslexiaMode:
		theme = load("res://Capstone-Project-Amogh-Mukherjee/Assets/space-worm-theme/space_worm_dyslexia_mode.tres")
		print(theme)
	else:
		theme = load("res://Capstone-Project-Amogh-Mukherjee/Assets/space-worm-theme/space_worm_theme.tres")

func _on_resume_pressed() -> void:
	self.hide()
	player_cam.pause()


func _on_quit_pressed() -> void:
	get_tree().quit()



func _on_options_pressed() -> void:
	regular_menu.hide()
	accessibility.show()


func _on_return_pressed() -> void:
	accessibility.hide()
	regular_menu.show()


func _on_dyslexia_mode_pressed() -> void:
	if dyslexia_mode:
		utils.dyslexiaMode = false
	else:
		utils.dyslexiaMode = true
	
	
