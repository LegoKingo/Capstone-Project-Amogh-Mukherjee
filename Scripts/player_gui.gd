extends Control

@onready var boost_icon = $Boost
@onready var dodge_icon = $Dodge
@onready var bomb_icon = $Bombs
@onready var lives = $Lives
@onready var boost_fade = $Boost/BoostFade
@onready var dodge_fade = $Dodge/DodgeFade
@onready var bomb_fade = $Bombs/BombFade
@onready var i_timer = $InvincibilityTimer
@onready var boost_timer = $BoostCooldown
@onready var score_display = $Score
@onready var utils = get_node("/root/Utilities")

var bomb_fade_count = 0
var boost_fade_count = 0
var dodge_fade_count = 0

func _ready():
	set_GUI()
	score_display.text = "Score: " + str(utils.current_score) + " / " + str(utils.target_score)
	utils.score_changed.connect(update_score)
	

func update_score(added_score: int):
	score_display.text = "Score: " + str(utils.current_score) + " / " + str(utils.target_score)

func set_GUI():
	if utils.boostUnlock:
		boost_icon.show()
		utils.boosted.connect(boost_fade.start)
	if utils.dodgeUnlock:
		utils.dodge_executed.connect(dodge_fade.start)
		dodge_icon.show()
	if utils.bombUnlock:
		utils.bomb_exploded.connect(bomb_fade.start)
		bomb_icon.show()

func _on_boost_fade_timeout() -> void:
	boost_fade_count += 1
	boost_icon.visible = !boost_icon.visible
	if boost_fade_count == 15:
		boost_fade.stop()
		boost_fade_count = 0
		boost_icon.show()
		return


func _on_dodge_fade_timeout() -> void:
	dodge_fade_count += 1
	dodge_icon.visible = !dodge_icon.visible
	if dodge_fade_count == 5:
		dodge_fade.stop()
		dodge_fade_count = 0
		dodge_icon.show()
		return


func _on_bomb_fade_timeout() -> void:
	bomb_fade_count += 1
	bomb_icon.visible = !bomb_icon.visible
	if utils.bombCounter == 3:
		bomb_icon.queue_free()
	if bomb_fade_count == 6:
		bomb_fade.stop()
		bomb_fade_count = 0
		bomb_icon.show()
		return
