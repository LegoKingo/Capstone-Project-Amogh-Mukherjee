extends Node
class_name LevelManager


const player_start_position = Vector2(960,540)
@onready var utils = get_node("/root/Utilities")
@onready var lives = utils.max_lives

var score = 0

var player_scene = preload("res://Capstone-Project-Amogh-Mukherjee/Scenes/player.tscn")
var game_over_scene
@onready var player = $"../Player" as Player

func _ready() -> void:
	
	utils.game_over = false
	utils.quit_early = false
	utils.time_up = false
	utils.bombCounter = 0
	utils.dodgeCounter = 0
	utils.boostCounter = 0
	utils.pauseCounter = 0
	utils.looped_bullets = 0
	utils.target_score = utils.base_t_score
	utils.target_score += utils.current_loan_size
	utils.current_score = score
	utils.score_changed.connect(change_score)
	player.on_player_died.connect(decrease_lives)


func decrease_lives():
	lives -= 1;
	if lives != 0:
		var new_player = player_scene.instantiate() as Player
		new_player.on_player_died.connect(decrease_lives)
		call_deferred("respawn",new_player)
		utils.lost_life.emit()
	else:
		game_over()


func respawn(player: Player):
	get_tree().root.get_node("Level").add_child(player)
	player.global_position = player_start_position
	player.start_invincibility()

func game_over():
	utils.game_over = true
	utils.end_of_game.emit()

func change_score(added_score: float):
	score += added_score
	utils.current_score += added_score
	if score >= utils.target_score:
		end_game()

func end_game():
	utils.endOfLevelScore = score
	utils.lives_left = lives
	utils.game_over = false
	utils.end_of_game.emit()
