extends Control

@onready var utils = get_node("/root/Utilities")
@onready var text_data = get_node("/root/TextReader")
@onready var item_array = ["Move Backwards", "Pause", "BGM", "Boost", "Dodge", "Bomb", "Looping Bullets"]
@onready var wager_button = $VBoxContainer/Loan
@onready var timer = $Timer
@onready var money_changer = $CurrentBalance/MoneyChanger
@onready var current_balance = $CurrentBalance

var item_price: int 

func _ready() -> void:
	if utils.wagers_unlocked:
		wager_button.show()
	else:
		wager_button.hide()
	current_balance.text = str(utils.current_balance)
	utils.successful_transaction.connect(change_the_money)
	utils.item_selected.connect(price_set)
	timer.timeout.connect(hide_alert)

func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	utils.item_selected.emit(index)

func price_set(index: int):
	item_price = int(text_data.items[index][3])

func change_the_money(item_index):
	money_changer.text = "-" + str(item_price) + " Credits"
	money_changer.show()
	var balance_new = utils.current_balance - item_price
	current_balance.text = str(balance_new)
	utils.current_balance = balance_new
	timer.start()

func hide_alert():
	money_changer.hide()


func _on_loan_pressed() -> void:
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/loan_application.tscn")
	pass # Replace with function body.


func _on_graduate_pressed() -> void:
	get_tree().change_scene_to_file("res://Capstone-Project-Amogh-Mukherjee/Scenes/graduation_application.tscn")
	pass # Replace with function body.
