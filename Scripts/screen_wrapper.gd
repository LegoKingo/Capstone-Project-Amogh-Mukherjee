extends Node

var node : Node2D
var rect : Vector2
func _ready() -> void:
	node = get_parent()
	rect = get_viewport().size

func _process(_delta):
	node.position.x = wrapf(node.position.x, 0, rect.x)
	node.position.y = wrapf(node.position.y, 0, rect.y)
