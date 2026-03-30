extends Control
@onready var utils = get_node("/root/Utilities")
@onready var title = $GameOverTitle
@onready var text = $GameOverText
@onready var return_button = $VBoxContainer/Return
@onready var quit = $VBoxContainer/Quit


func _ready() -> void:
	if utils.quit_early:
		title.text = "YOU QUIT!"
		text.text = "I pulled ye out of the game by yer request. Be sure to take breaks. Everyone who washes out of the program washes out because they didn't know when to rest!"
		quit.hide()
		return
	if utils.current_loan_size > 0:
		title.text = "Wager Lost"
		text.text = "I honestly thought ye woullda been able to pull it off kid. A wager is a wager though, I'm revoking yer access to the system."
		return_button.hide()
		return
	if utils.time_up:
		title.text = "Ran out of Time"
		increase_timer()
		text.text = "Engaging 'Dynamic Difficulty' Protocol. Increasing timer for future playthroughs. New time limit: " + str(round(utils.timer_wait_time)) + " seconds"
		quit.hide()
		return
	if utils.game_over:
		title.text = "Out of Lives"
		text.text = "Engaging 'Game Over' Protocol. Returning player to dashboard..."
		quit.hide()
		return


func increase_timer():
	if utils.timer_wait_time >= 200.0:
		utils.timer_wait_time *= 1.1
		return
	utils.timer_wait_time *= 1.5


func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/main_menu.tscn")

func _on_quit_pressed() -> void:
	utils.lost_game = true
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/end_of_game.tscn")
