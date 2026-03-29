extends Control
@onready var utils = get_node("/root/Utilities")
@onready var title = $GameOverTitle
@onready var text = $GameOverText
@onready var return_button = $VBoxContainer/Return
@onready var quit = $VBoxContainer/Quit


func _ready() -> void:
	if utils.quit_early:
		title.text = "YOU QUIT!"
		text.text = "'The masses take frequent breaks from their labor to play. The wisest few know that it is better to make ones work feel like play instead.'
		-Flow Inc Bylaws"
		quit.hide()
		return
	if utils.current_loan_size > 0:
		title.text = "Wager Lost"
		text.text = "GAMBLING MALWARE DETECTED. CONTACTING SECURITY. LETHAL FORCE APPROVED."
		return_button.hide()
		return
	if utils.game_over:
		title.text = "Out of Lives"
		text.text = "'It is nothing to die in the virtual world. We may return to it as many times as we desire'
		-Flow Inc Bylaws"
		quit.hide()
		return
	if utils.time_up:
		title.text = "Ran out of Time"
		text.text = "'There is only one known defence against the passage of time-- the inexhaustible flow of play'
		- Flow Inc Motto"
		quit.hide()
		return


func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/main_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
