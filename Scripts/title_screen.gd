extends Control

@onready var level_select
@onready var credits = $CreditsPage
@onready var title_page = $TitlePage
@onready var options_page = $OptionsPage
@onready var start_button = $TitlePage/MarginContainer/VBoxContainer/StartGame
@onready var utils = get_node("/root/Utilities")
@onready var slider = get_node("OptionsPage/MarginContainer/VBoxContainer/HSlider")


func _ready() -> void:
	slider.value = utils.gameSpeedMult * 100
	if utils.game_started:
		start_button.text = "Continue"

func _on_start_game_pressed() -> void:
	if utils.game_started == false:
		utils.add_email.emit(1)
	utils.game_started = true
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/main_menu.tscn")

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


func _on_quit_pressed() -> void:
	utils.quit_game = true
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/end_of_game.tscn")
