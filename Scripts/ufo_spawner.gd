extends Node

@export var ufo_scene : PackedScene

@onready var timer = $Timer as UFO_Timer
@onready var top_path = $TopPath/PathToFollow1
@onready var bottom_path = $BottomPath/PathToFollow2

func _ready():
	timer.timeout.connect(spawn_ufo)

func spawn_ufo():
	var ufo = ufo_scene.instantiate() as UFO
	var path_to_follow = top_path if randf() > 0.5 else bottom_path as PathFollow2D
	
	if path_to_follow.get_child_count() != 0:
		return
	
	path_to_follow.progress = 0
	ufo.path = path_to_follow
	path_to_follow.add_child(ufo)
	timer.setup_timer()
	timer.start()
