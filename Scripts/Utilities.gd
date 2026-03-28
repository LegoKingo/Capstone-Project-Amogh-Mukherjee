extends Node

#List of Planned Store Items For Game + Implementation Level
# -Looping Bullets
	# Code implemented
# -Backwards Movement
	# Code implemented
# -Boost
	# Rough feature implemented
# -Dodge/On-Demand Invincibility
	# Implemented
# -Bomb
	# Partially Implemented
# -Score Laundering
	# Not Implemented (needs score system first)
# -Music
	# Not Implemented 
# -Pause Button
	# Rough feature implemented, needs menu
# -Email System (Forced Purchase)
	# needs menu first before feature can be implemented
# -Shop Tax (Forced Purchase)
	# needs menu + score system before it can be implemented



var dodgeCounter: int = 0
var bombCounter: int = 0
var pauseCounter: int = 0
var gameSpeedMult = 1.0

var max_lives: int = 3
var tutorial_complete: bool = false
var loopingBullets : bool = false
const loopMax: int = 3
var backwardsMovement : bool = false
var boostUnlock : bool = true
var dodgeUnlock: bool = true
var bombUnlock: bool = true
var scoreLaundering: bool = false
var musicOn: bool = false
var musicPurchase : bool = true
var pauseUnlock: bool = true
var shopUnlock: bool = false
var emailUnlock: bool = false

signal game_speed_changed(newSpeed: float)
signal score_changed(addScore: float)
signal bomb_exploded()
signal play_explosion()

var endOfLevelScore : float
var moneyCount : float

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
