extends Control

@onready var timer = $Timer
@onready var audio = $AudioStreamPlayer2D


func _ready() -> void:
	timer.timeout.connect(queue_free)
	audio.play()
	
