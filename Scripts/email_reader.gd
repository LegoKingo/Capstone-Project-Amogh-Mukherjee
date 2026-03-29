extends Control

@onready var sender = $Sender
@onready var subject_line = $SubjectLine
@onready var email_body = $EmailBody
@onready var utils = get_node("/root/Utilities")

func _ready() -> void:
	subject_line.text = "Subject: This is Email #" + str(utils.current_email + 1)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/emails.tscn")
