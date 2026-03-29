extends Control

@onready var utils = get_node("/root/Utilities")
@onready var timer = $Timer
@onready var denial_message = $DenialMessage

func _ready() -> void:
	timer.timeout.connect(hide_message)

func _on_apply_pressed() -> void:
	if utils.current_balance >= 100000:
		pass
	else:
		denial_message.show()
		timer.start()

func hide_message():
	denial_message.hide()
