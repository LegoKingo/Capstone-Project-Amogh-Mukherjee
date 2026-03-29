extends Node

var path_email = "res://Capstone-Project-Amogh-Mukherjee/Assets/Data/EmailText.csv"
var path_items = "res://Capstone-Project-Amogh-Mukherjee/Assets/Data/item_shop.csv"
var rows
var items

func _ready() -> void:
	rows = get_data(path_email)
	items = get_data(path_items)



func get_data(data_path):
	var maindata = {}
	var f = FileAccess.open(data_path,FileAccess.READ)
	while !f.eof_reached():
		var data_set = Array(f.get_csv_line())
		maindata[maindata.size()] = data_set
	f.close()
	
	return maindata
	
