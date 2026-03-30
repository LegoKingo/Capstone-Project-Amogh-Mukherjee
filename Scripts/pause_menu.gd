extends Control

@onready var player_cam = get_parent().get_parent()
@onready var regular_menu = get_node("MarginContainer/RegularMenu")
@onready var accessibility = get_node("MarginContainer/Accessibility")
@onready var utils = get_node("/root/Utilities")
@onready var pause_title = get_node("PausedTitle")
@onready var accessibility_title = get_node("AccessibilityTitle")
@onready var slider = get_node("MarginContainer/Accessibility/HSlider")
@onready var music_box = get_node("MarginContainer/Accessibility/CheckButton")

signal play_music(should_play: bool)

@onready var current_theme = get_tree().root.theme


func _ready() -> void:
	slider.value = utils.gameSpeedMult * 100
	if utils.store_dictionary["Music"]:
		music_box.show()
	else:
		music_box.hide()
func _on_resume_pressed() -> void:
	self.hide()
	player_cam.pause()


func _on_quit_pressed() -> void:
	utils.quit_early = true
	utils.game_over = true
	player_cam.pause()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	utils.end_of_game.emit()



func _on_options_pressed() -> void:
	regular_menu.hide()
	pause_title.hide()
	accessibility_title.show()
	accessibility.show()


func _on_return_pressed() -> void:
	accessibility.hide()
	accessibility_title.hide()
	pause_title.show()
	regular_menu.show()


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		utils.gameSpeedMult = slider.value / 100
		utils.game_speed_changed.emit(utils.gameSpeedMult)


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		play_music.emit(true)
	else:
		play_music.emit(false)
