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

@onready var email_pop_up = preload("res://Capstone-Project-Amogh-Mukherjee/Scenes/email_pop_up.tscn")


var dodgeCounter: int = 0
var bombCounter: int = 0
var boostCounter: int = 0
var pauseCounter: int = 0
var gameSpeedMult = 1.0
var max_lives: int = 3
const loopMax: int = 3
var levels_played: int = 0
var lives_left: int
var target_score = 2500
var base_t_score = 2500

var wagers_unlocked: bool = false
var tutorial_complete: bool = false
var graduation_unlocked: bool = true
var game_started: bool = false
var quit_early: bool = false
var game_over = false
var time_up = false
var looped_bullets: int
var lifer_friendship: bool = false

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
var end_game_unlock: bool = false
var loop_email_sent: bool = false

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

var email_array: Array[int] = []

#email_dictionary_hints:
# 0: Onboarding
# 1: Lifer intro
# 2: Shopkeeper intro
# 3: Lifer musing
# 4: Unlock Wager
# 5: Lifer parable
# 6: Unlock Graduation
# 7: Bought Looping
# 8: Bought Everything
# 9: Graduation

var email_dictionary = {
	0 : 1, 
	1 : 2,
	2 : 3,
	3 : 4,
	4 : 5,
	5 : 6,
	6 : 7,
	7 : 8,
	8 : 9,
	9 : 10,
}

var read_emails_array: Array[bool] = [
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false
]

var email_count = 0
var max_emails = 10
var read_emails: int = 0
var current_email: int
var current_balance = 250
var purchase_count = 0


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
signal successful_transaction(index_num: int)
signal end_of_game()
signal add_email(email_num: int)
signal lost_life()

var current_score: int
var endOfLevelScore : int
var moneyCount : int
var timer_wait_time: float = 60.0

var lost_game: bool = false
var quit_game: bool = false


func _ready() -> void:
	successful_transaction.connect(set_bool)
	add_email.connect(add_an_email)
	process_mode = Node.PROCESS_MODE_ALWAYS

func set_bool(item_index: int):
	store_dictionary[store_items[item_index]] = true
	if (store_items[item_index] == "Looping Bullets"):
		add_email.emit(8)
	


func add_an_email(email_index: int):
	email_array.append(email_index)
	email_count += 1
	var pop_up = email_pop_up.instantiate()
	get_tree().root.add_child(pop_up)
