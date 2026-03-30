extends Control

@onready var utils = get_node("/root/Utilities")
@onready var final_payout = $PayoutLabel/FinalPayout
@onready var score_modifiers = $ScoreModifiers
@onready var eol_score = $EndofLevelScore
var debt_check: bool
var score_mods: Array[String] = []
var final_payout_score
var music_royalties = 2000
var pause_cost = 500
var bomb_cost = 1500
var dodge_cost = 750
var boost_cost = 600
var life_value = 250
var looped_bullet_value = 1000
func _ready() -> void:
	utils.levels_played += 1
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	eol_score.text = "Score: " + str(utils.endOfLevelScore)+ " points"
	calculate_deductions()
	unlocks_check()
	for i in score_mods:
		score_modifiers.text += i
	utils.current_balance += utils.endOfLevelScore
	final_payout.text = str(utils.endOfLevelScore) + " Credits"
	utils.current_score = 0


func calculate_deductions():
	music_check()
	pause_check()
	dodge_check()
	bombs_check()
	boost_check()
	taxation_algorithm()
	lives_check()
	loan_check()
	loop_check()
	balance_check()
	increase_difficulty()

func increase_difficulty():
	var prog_number = utils.levels_played % 2
	if prog_number == 0:
		utils.base_t_score += 1000
		var prog_mod = "[p]Successful performance detected. Increasing target score.[/p]"
		score_mods.append(prog_mod)

func unlocks_check():
	if utils.levels_played == 1:
		utils.add_email.emit(2)
	if utils.levels_played == 2:
		utils.add_email.emit(3)
	if utils.levels_played == 3:
		utils.add_email.emit(5)
	if utils.levels_played == 5:
		utils.add_email.emit(6)
	if utils.levels_played == 20:
		utils.graduation_unlocked = true
	if utils.successful_wagers == 5:
		utils.add_email.emit(7)

func music_check():
	if utils.musicOn:
		utils.endOfLevelScore -= music_royalties
		var music_mod = "[p]Music Royalty Fees: -1000 points[/p]"
		score_mods.append(music_mod)

func pause_check():
	if utils.store_dictionary["Pause Button"]:
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
	if utils.lives_left == 1:
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
	utils.successful_wagers += 1
	if utils.successful_wagers == 5:
		pass
	score_mods.append(loan_mod)
	utils.current_loan_size = 0
	utils.target_score = utils.base_t_score

func loop_check():
	if !utils.store_dictionary["Looping Bullets"]:
		return
	var loop_bonus = utils.looped_bullets * looped_bullet_value
	utils.endOfLevelScore += loop_bonus
	if utils.looped_bullets == 1:
		var loop_mod = "[p]" + str(utils.looped_bullets) + " bullet looped: " + str(loop_bonus)+ " points[/p]"
		score_mods.append(loop_mod)
	else:
		var loop_mod = "[p]" + str(utils.looped_bullets) + " bullets looped: " + str(loop_bonus)+ " points[/p]"
		score_mods.append(loop_mod)
 
func balance_check():
	if debt_check:
		return
	if utils.endOfLevelScore < 0:
		utils.add_email.emit(11)
		debt_check = true
		var debt_mod = "[p] Losses too great... Debt Incurred. Contacting Adminstrator. [/p]"
		score_mods.append(debt_mod)

func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/main_menu.tscn")
