extends Camera2D

@onready var pause_scene = $CanvasLayer/PauseMenu
@onready var paused: bool = false
@onready var utils = get_node("/root/Utilities")

@onready var pause_counter = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") && utils.pauseUnlock:
		pause()

func pause():
	if get_tree().paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pause_scene.hide()
		get_tree().paused = false
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pause_scene.show()
		get_tree().paused = true
