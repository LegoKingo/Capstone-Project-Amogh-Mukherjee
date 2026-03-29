extends Control

@onready var utils = get_node("/root/Utilities")
@onready var final_payout = $PayoutLabel/FinalPayout
@onready var score_modifiers = $ScoreModifiers
@onready var eol_score = $EndofLevelScore

var score_mods: Array[String] = []
var final_payout_score
var music_royalties = 1000
var pause_cost = 100
var bomb_cost = 1000
var dodge_cost = 500
var boost_cost = 400
var life_value = 500

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	eol_score.text = "Score: " + str(utils.endOfLevelScore)+ " points"
	calculate_deductions()
	for i in score_mods:
		score_modifiers.text += i
	utils.current_balance += utils.endOfLevelScore
	final_payout.text = str(utils.endOfLevelScore) + " Credits"


func calculate_deductions():
	music_check()
	pause_check()
	dodge_check()
	bombs_check()
	boost_check()
	taxation_algorithm()
	lives_check()
	loan_check()


func music_check():
	if utils.musicOn:
		utils.endOfLevelScore -= music_royalties
		var music_mod = "[p]Music Royalty Fees: -1000 points[/p]"
		score_mods.append(music_mod)

func pause_check():
	if utils.pauseUnlock:
		if utils.pauseCounter == 0:
			return
		var pause_penalty = utils.pauseCounter * pause_cost
		utils.endOfLevelScore -= pause_penalty
		if utils.pauseCounter > 1:
			var pause_mod = "[p]Used pause button " + str(utils.pauseCounter) + " times: -" + str(pause_penalty) + " points[/p]"
			score_mods.append(pause_mod)
		else:
			var pause_mod = "[p]One pause used: -" +str(pause_penalty) + " points[/p]"
			score_mods.append(pause_mod)

func dodge_check():
	if utils.dodgeCounter == 0:
		return
	var dodge_penalty = utils.dodgeCounter * dodge_cost
	utils.endOfLevelScore -= dodge_penalty
	if utils.dodgeCounter > 1:
		var dodge_mod = "[p]Used dodge " + str(utils.dodgeCounter) + " times: -" + str(dodge_penalty) + " points[/p]"
		score_mods.append(dodge_mod)
	else:
		var dodge_mod = "[p]One dodge used: -" +str(dodge_penalty) + " points[/p]"
		score_mods.append(dodge_mod)

func bombs_check():
	if utils.bombCounter == 0:
		return
	var bomb_penalty = utils.bombCounter * bomb_cost
	utils.endOfLevelScore -= bomb_penalty
	if utils.bombCounter > 1:
		var bomb_mod = "[p]Used bombs " + str(utils.bombCounter) + " times: -" + str(bomb_penalty) + " points[/p]"
		score_mods.append(bomb_mod)
	else:
		var bomb_mod = "[p]One bomb used: -" +str(bomb_penalty) + " points[/p]"
		score_mods.append(bomb_mod)

func boost_check():
	if utils.boostCounter == 0:
		return
	var boost_penalty = utils.boostCounter * boost_cost
	utils.endOfLevelScore -= boost_penalty
	if utils.boostCounter > 1:
		var boost_mod = "[p]Used dodge " + str(utils.boostCounter) + " times: -" + str(boost_penalty) + " [/p]points"
		score_mods.append(boost_mod)
	else:
		var boost_mod = "[p]One boost used: -" +str(boost_penalty) + " points/[p]"
		score_mods.append(boost_mod)

func taxation_algorithm():
	utils.endOfLevelScore /= 2
	var tax_mod = "[p]Flow Inc's Data Usage Fee: -50% score[/p]"
	score_mods.append(tax_mod)


func lives_check():
	var life_bonus = utils.lives_left * life_value
	utils.endOfLevelScore += life_bonus
	if utils.lives_left > 1:
		var life_mod = "[p]One life remaining: +" + str(life_bonus) + " points[/p]"
		score_mods.append(life_mod)
	else:
		var life_mod = "[p]" + str(utils.lives_left) +" lives remaining: +" + str(life_bonus) + " points[/p]"
		score_mods.append(life_mod)
		

func loan_check():
	if utils.current_loan_size == 0:
		return
	utils.endOfLevelScore += utils.current_loan_size
	var loan_mod = "[p]WAGER COMPLETED: +" + str(utils.current_loan_size) + " points[/p]"
	score_mods.append(loan_mod)
	utils.current_loan_size = 0


func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/main_menu.tscn")
