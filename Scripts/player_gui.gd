extends Control

@onready var boost_icon = $Boost
@onready var dodge_icon = $Dodge
@onready var bomb_icon = $Bombs
@onready var lives = $Lives
@onready var timer = $FadingTimer
@onready var score_display = $Score
@onready var utils = get_node("/root/Utilities")


func _ready():
	pass
