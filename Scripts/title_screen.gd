extends Control

@onready var level_select
@onready var credits = $CreditsPage
@onready var title_page = $TitlePage
@onready var options_page = $OptionsPage
@onready var utils = get_node("/root/Utilities")
@onready var slider = get_node("OptionsPage/MarginContainer/VBoxContainer/HSlider")

var open_dyslexic = preload("res://Capstone-Project-Amogh-Mukherjee/Assets/space-worm-theme/fonts/OpenDyslexic-Regular.otf")

func _ready() -> void:
	slider.value = 100.0

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


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		utils.gameSpeedMult = slider.value / 100
