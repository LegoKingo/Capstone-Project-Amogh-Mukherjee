extends Control

@onready var sender = $Sender
@onready var subject_line = $SubjectLine
@onready var email_body = $EmailBody
@onready var utils = get_node("/root/Utilities")
@onready var text_data = get_node("/root/TextReader")

func _ready() -> void:
	subject_line.text = "Subject: " + text_data.rows[utils.current_email][2]
	sender.text = "From: " + text_data.rows[utils.current_email][1]
	email_body.text = text_data.rows[utils.current_email][3]


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/emails.tscn")
