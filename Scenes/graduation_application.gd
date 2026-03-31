extends Control

@onready var utils = get_node("/root/Utilities")
@onready var timer = $Timer
@onready var denial_message = $DenialMessage
@onready var s_message = $SuccessMessage
@onready var s_timer = $SuccessTimer

func _ready() -> void:
	timer.timeout.connect(hide_message)
	s_timer.timeout.connect(graduation_time)

func _on_apply_pressed() -> void:
	if utils.current_balance >= 50000:
		utils.add_email.emit(10)
		s_message.show()
		s_timer.start()
	else:
		denial_message.show()
		timer.start()

func graduation_time():
	utils.current_email = 9
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/email_reader.tscn")
	pass
	
func hide_message():
	denial_message.hide()
