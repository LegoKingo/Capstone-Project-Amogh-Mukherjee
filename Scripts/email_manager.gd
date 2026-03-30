extends Control

@onready var utils = get_node("/root/Utilities")
@onready var text_data = get_node("/root/TextReader")
@onready var email_list = $EmailList
@onready var unopened_email = preload("res://Capstone-Project-Amogh-Mukherjee/Assets/closed_envelope_alternate.png")
@onready var opened_mail = preload("res://Capstone-Project-Amogh-Mukherjee/Assets/open_envelope.png")
signal add_new_email(email_num: int)

var email_id_arr = []

@onready var emails_total = email_list.get_item_count()

@onready var email_count = utils.email_count
func _ready() -> void:
	for i in utils.email_array:
		add_email(i)
	
	emails_total = email_list.get_item_count()
	add_new_email.connect(add_email)



func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	var email_id = email_id_arr[index]
	utils.read_emails_array[email_id] = true
	utils.current_email = email_id
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/email_reader.tscn")


func add_email(email_num: int):
	var email_title = text_data.rows[email_num-1][2] + " ---- " + text_data.rows[email_num-1][1]
	email_id_arr.append(email_num-1)
	if utils.read_emails_array[email_num-1] == true:
		email_list.add_item(email_title, opened_mail)
	else:
		email_list.add_item(email_title, unopened_email)
