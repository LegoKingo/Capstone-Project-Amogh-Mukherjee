extends Control

@onready var email_button = $MarginContainer/VBoxContainer/Emails
@onready var utils = get_node("/root/Utilities")

var closed_envelope = "res://Capstone-Project-Amogh-Mukherjee/Assets/closed_envelope_alternate.png"
var open_envelope = "res://Capstone-Project-Amogh-Mukherjee/Assets/open_envelope.png"
var emails_page = "res://Capstone-Project-Amogh-Mukherjee/Scenes/emails.tscn"
var store_page = "res://Capstone-Project-Amogh-Mukherjee/Scenes/store.tscn"
var level_page = "res://Capstone-Project-Amogh-Mukherjee/Scenes/level.tscn"

func _ready() -> void:
	if utils.unreadEmails:
		email_button.icon = ResourceLoader.load(closed_envelope)
	else:
		email_button.icon = ResourceLoader.load(open_envelope)


func _on_start_level_pressed() -> void:
	get_tree().change_scene_to_file(level_page)


func _on_store_pressed() -> void:
	get_tree().change_scene_to_file(store_page)


func _on_emails_pressed() -> void:
	get_tree().change_scene_to_file(emails_page)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/title_screen.tscn")
