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
var boostCounter: int = 0
var pauseCounter: int = 0
var gameSpeedMult = 1.0
var max_lives: int = 3
const loopMax: int = 3
var levels_played: int = 0
var lives_left: int

var tutorial_complete: bool = false
var game_started: bool = false
var quit_early: bool = false
var game_over = false
var time_up = false


var loopingBullets : bool = false
var backwardsMovement : bool = false
var boostUnlock : bool = true
var dodgeUnlock: bool = true
var bombUnlock: bool = true
var scoreLaundering: bool = true
var musicOn: bool = true
var musicPurchase : bool = true
var pauseUnlock: bool = true
var unreadEmails: bool = true

var store_dictionary = {
	"Move Backwards": backwardsMovement, 
	"Pause Button": pauseUnlock,
	"Music": musicPurchase, 
	"Boost": boostUnlock, 
	"Dodge": dodgeUnlock, 
	"Bomb": bombUnlock,
	"Looping Bullets": loopingBullets}

var store_items: Array = store_dictionary.keys()

var icon_array = [
	"res://Capstone-Project-Amogh-Mukherjee/Assets/move_backwards.png",
	"res://Capstone-Project-Amogh-Mukherjee/Assets/pause_button.png",
	"res://Capstone-Project-Amogh-Mukherjee/Assets/music.png",
	"res://Capstone-Project-Amogh-Mukherjee/Assets/boost.png",
	"res://Capstone-Project-Amogh-Mukherjee/Assets/dodge.png",
	"res://Capstone-Project-Amogh-Mukherjee/Assets/bomb.png",
	"res://Capstone-Project-Amogh-Mukherjee/Assets/looping_bullets.png"
]

var email_count = 0
var max_emails = 10
var read_emails: Array[bool] = []
var current_email: int
var current_balance = 100

var current_loan_size: int = 0

signal game_speed_changed(newSpeed: float)
signal score_changed(addScore: float)
signal bomb_exploded()
signal play_explosion()
signal item_selected(index: int)
signal update_money()
signal add_new_email(email_num: int)
signal successful_transaction()
signal end_of_game()

var currentScore: int
var endOfLevelScore : int
var moneyCount : int

func _ready() -> void:
	read_emails.resize(max_emails)
	read_emails.fill(false)
	process_mode = Node.PROCESS_MODE_ALWAYS
