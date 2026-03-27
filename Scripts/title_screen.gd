extends Control

@onready var level_select
@onready var credits = $CreditsPage
@onready var title_page = $TitlePage
@onready var options_page = $OptionsPage
@onready var utils = get_node("/root/Utilities")

var open_dyslexic = preload("res://Capstone-Project-Amogh-Mukherjee/Assets/space-worm-theme/fonts/OpenDyslexic-Regular.otf")

func _ready() -> void:
	if utils.dyslexiaMode:
		print("dyslexia mode on")
		add_theme_font_override("OpenDyslexic", open_dyslexic)
	else:
		print("dyslexia mode off!")
		theme = load("res://Capstone-Project-Amogh-Mukherjee/Assets/space-worm-theme/space_worm_theme.tres")

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/level.tscn")

func _on_options_pressed() -> void:
	title_page.hide()
	options_page.show()


func _on_credits_pressed() -> void:
	title_page.hide()
	credits.show()


func _on_return_pressed() -> void:
	credits.hide()
	options_page.hide()
	title_page.show()


func _on_accessibility_pressed() -> void:
	utils.dyslexiaMode = true
	get_tree().reload_current_scene()
