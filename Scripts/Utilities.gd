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

var loopingBullets : bool = false
const loopMax: int = 3
var backwardsMovement : bool = false
var boostUnlock : bool = true
var dodgeUnlock: bool = true
var bombUnlock: bool = false
var scoreLaundering: bool = false
var MusicUnlock: bool = false
var pauseUnlock: bool = true
var shopUnlock: bool = false
var emailUnlock: bool = false

var dyslexiaMode: bool = true
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
