extends Camera2D

@onready var pause_scene = $CanvasLayer/PauseMenu
@onready var paused: bool = false
@onready var utils = get_node("/root/Utilities")
@onready var music = $AudioStreamPlayer2D

func _ready() -> void:
	utils.pauseCounter = 0
	pause_scene.play_music.connect(music_toggle)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") && utils.pauseUnlock:
		pause()
		utils.pauseCounter += 1

func pause():
	if get_tree().paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pause_scene.hide()
		get_tree().paused = false
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pause_scene.show()
		get_tree().paused = true

func music_toggle(should_play: bool):
	if should_play:
		music.play()
	else:
		music.stop()
