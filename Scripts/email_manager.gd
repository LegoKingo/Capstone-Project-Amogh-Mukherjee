extends Control

@onready var utils = get_node("/root/Utilities")
@onready var text_data = get_node("/root/TextReader")
@onready var email_list = $EmailList
@onready var unopened_email = preload("res://Capstone-Project-Amogh-Mukherjee/Assets/closed_envelope_alternate.png")
@onready var opened_mail = preload("res://Capstone-Project-Amogh-Mukherjee/Assets/open_envelope.png")
signal add_new_email(email_num: int)

@onready var emails_total = email_list.get_item_count()

@onready var email_count = utils.email_count
func _ready() -> void:
	if utils.email_count > 1:
		for i in utils.email_count:
			add_email(i+1)
	utils.unreadEmails = !utils.unreadEmails
	add_new_email.connect(add_email)



func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	email_list.set_item_icon(index, opened_mail)
	utils.read_emails[index] = true
	utils.current_email = index
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/email_reader.tscn")


func _on_button_pressed() -> void:
	email_count += 1
	if email_count > utils.max_emails:
		return
	utils.email_count = email_count
	add_new_email.emit(email_count)

func add_email(email_num: int):
	if email_count > utils.max_emails:
		return
	var email_title = text_data.rows[email_num-1][2] + " from " + text_data.rows[email_num-1][1]
	if utils.read_emails[email_num-1] == true:
		email_list.add_item(email_title, opened_mail)
	else:
		email_list.add_item(email_title, unopened_email)
