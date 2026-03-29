extends AudioStreamPlayer2D

var explosion = self
@onready var utils = get_node("/root/Utilities")
func _ready():
	utils.play_explosion.connect(play_sound)

func play_sound():
	if !is_inside_tree():
		return
	explosion.play()
	print("explosion")
