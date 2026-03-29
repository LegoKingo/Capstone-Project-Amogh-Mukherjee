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
	# Implemented
# -Music
	# Implemented 
# -Pause Button
	# Implemented
# -Email System
	# write emails + boolean logic
# -Shop Tax 
	# hide purchase button



var dodgeCounter: int = 0
var bombCounter: int = 0
var boostCounter: int = 0
var pauseCounter: int = 0
var gameSpeedMult = 1.0
var max_lives: int = 3
const loopMax: int = 3
var levels_played: int = 0
var lives_left: int
var target_score = 5000

var wagers_unlocked: bool = false
var tutorial_complete: bool = false
var game_started: bool = false
var quit_early: bool = false
var game_over = false
var time_up = false
var bullets_looped: int


var loopingBullets : bool = false
var backwardsMovement : bool = false
var boostUnlock : bool = false
var dodgeUnlock: bool = false
var bombUnlock: bool = false
var musicOn: bool = false
var musicPurchase : bool = false
var pauseUnlock: bool = false
var unreadEmails: bool = false
var store_unlock: bool = false

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
var current_balance = 1000

var current_loan_size: int = 0
var successful_wagers: int = 0

signal game_speed_changed(newSpeed: float)
signal score_changed(addScore: float)

signal bomb_exploded()
signal dodge_executed()
signal boosted()
signal play_explosion()
signal item_selected(index: int)
signal update_money()
signal add_new_email(email_num: int)
signal successful_transaction(index_num: int)
signal end_of_game()

var current_score: int
var endOfLevelScore : int
var moneyCount : int

func _ready() -> void:
	successful_transaction.connect(set_bool)
	read_emails.resize(max_emails)
	read_emails.fill(false)
	process_mode = Node.PROCESS_MODE_ALWAYS

func set_bool(item_index: int):
	print(store_items[item_index] + "is" + str(store_dictionary[store_items[item_index]]))
	store_dictionary[store_items[item_index]] = true
	print(store_items[item_index] + "is" + str(store_dictionary[store_items[item_index]]))
