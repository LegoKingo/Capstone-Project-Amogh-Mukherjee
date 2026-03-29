extends Control

@onready var utils = get_node("/root/Utilities")
@onready var item_name = $ItemName
@onready var item_icon = $ItemName/ItemIcon
@onready var item_description = $ItemDescription
@onready var item_price = $ItemPrice
@onready var purchase_button = $PanelContainer/PurchaseButton
@onready var timer = $PanelContainer/PurchaseButton/Timer
@onready var transaction_failure = $PanelContainer/PurchaseButton/BrokeAlert
@onready var transaction_success = $PanelContainer/PurchaseButton/BallerAlert


func _ready():
	utils.item_selected.connect(display_item)
	timer.timeout.connect(hide_alert)

func display_item(item_index: int):
	purchase_button.show()
	item_name.text = utils.store_items[item_index]
	item_icon.texture = ResourceLoader.load(utils.icon_array[item_index])
	item_description.text = "This is where the text will go!"
	item_price.show()
	item_price.text = "One Billion"


func _on_purchase_button_pressed() -> void:
	var purchase_success: bool = attempt_purchase()
	if purchase_success:
		utils.successful_transaction.emit()
		transaction_success.show()
	else:
		transaction_failure.show()
	timer.start()

func hide_alert():
	transaction_failure.hide()
	transaction_success.hide()

func attempt_purchase() -> bool:
	var purchase_successful = true
	return purchase_successful
