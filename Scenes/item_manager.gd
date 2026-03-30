extends Control

@onready var utils = get_node("/root/Utilities")
@onready var text_data = get_node("/root/TextReader")
@onready var item_name = $ItemName
@onready var item_icon = $ItemName/ItemIcon
@onready var item_description = $ItemDescription
@onready var item_price = $ItemPrice
@onready var purchase_button = $PanelContainer/PurchaseButton
@onready var timer = $PanelContainer/PurchaseButton/Timer
@onready var transaction_failure = $PanelContainer/PurchaseButton/BrokeAlert
@onready var transaction_success = $PanelContainer/PurchaseButton/BallerAlert

var current_item_index: int


func _ready():
	utils.item_selected.connect(display_item)
	timer.timeout.connect(hide_alert)

func display_item(item_index: int):
	purchase_button.show()
	if utils.store_dictionary[utils.store_items[item_index]]:
		purchase_button.hide()
	current_item_index = item_index
	item_name.text = text_data.items[item_index][1]
	item_icon.texture = ResourceLoader.load(utils.icon_array[item_index])
	item_description.text = text_data.items[item_index][2]
	item_price.show()
	item_price.text = text_data.items[item_index][3]


func _on_purchase_button_pressed() -> void:
	var purchase_success: bool = attempt_purchase()
	if purchase_success:
		utils.successful_transaction.emit(current_item_index)
		utils.purchase_count += 1
		if utils.purchase_count == 7:
			utils.add_email.emit(9)
		transaction_success.show()
	else:
		transaction_failure.show()
	timer.start()

func hide_alert():
	if transaction_success.visible:
		purchase_button.hide()
	transaction_failure.hide()
	transaction_success.hide()

func attempt_purchase() -> bool:
	var purchase_successful: bool
	var item_cost = int(item_price.text)
	if utils.current_balance >= item_cost:
		purchase_successful = true
	else: 
		purchase_successful = false
	return purchase_successful
