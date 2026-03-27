extends Timer
class_name UFO_Timer

@export var min_time = 5
@export var max_time = 15

func _ready() -> void:
	setup_timer()

func setup_timer():
	var timeout_value = randi_range(min_time, max_time)
	self.wait_time = timeout_value
	self.start()
