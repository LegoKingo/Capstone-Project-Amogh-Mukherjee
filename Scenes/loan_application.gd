extends Control


@onready var utils = get_node("/root/Utilities")
@onready var current_balance = $CurrentBalance
@onready var loan_amount = $LoanAmount
@onready var button_one = $IncreaseLoan
@onready var button_two = $DecreaseLoan
@onready var button_three = $TakeOutLoan
@onready var current_loan = $Label

var increment_amt = 1000
var loan_total = 0

func _ready() -> void:
	if utils.current_loan_size > 0:
		wager_set()

func _on_increase_loan_pressed() -> void:
	if loan_total >= 10000:
		return
	loan_total += increment_amt
	loan_amount.text = str(loan_total)


func _on_decrease_loan_pressed() -> void:
	if loan_total <= 0:
		return
	loan_total -= increment_amt
	loan_amount.text = str(loan_total)


func _on_take_out_loan_pressed() -> void:
	utils.current_loan_size += loan_total
	wager_set()

func wager_set():
	current_loan.text = "Current Wager"
	loan_amount.text = str(utils.current_loan_size)
	button_one.hide()
	button_two.hide()
	button_three.hide()
