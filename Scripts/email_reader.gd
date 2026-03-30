extends Control

@onready var sender = $Sender
@onready var subject_line = $SubjectLine
@onready var email_body = $EmailBody
@onready var utils = get_node("/root/Utilities")
@onready var text_data = get_node("/root/TextReader")
@onready var end_game_button =  $HBoxContainer/EndGame
@onready var return_button = $HBoxContainer/Return
@onready var balance_button = $HBoxContainer/BalanceReset
func _ready() -> void:
	if !(utils.read_emails == utils.email_count):
		utils.read_emails += 1
	email_unlocks()
	if utils.end_game_unlock:
		end_game_button.show()
	subject_line.text = "Subject: " + text_data.rows[utils.current_email][2]
	sender.text = "From: " + text_data.rows[utils.current_email][1]
	email_body.text = text_data.rows[utils.current_email][3]

func email_unlocks():
	if utils.current_email == 0:
		utils.tutorial_complete = true
	if utils.current_email == 2:
		utils.store_unlock = true
		utils.add_email.emit(4)
	if utils.current_email == 4:
		utils.wagers_unlocked = true
	if utils.current_email == 6:
		utils.graduation_unlocked = true
	if utils.current_email == 7:
		utils.lifer_friendship == true
	if utils.current_email == 9:
		utils.end_game_unlock = true
	if utils.current_email == 10:
		balance_button.show()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/emails.tscn")


func _on_end_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/end_of_game.tscn")


func _on_balance_reset_pressed() -> void:
	utils.current_balance = 0
