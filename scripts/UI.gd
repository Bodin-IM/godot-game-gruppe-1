extends CanvasLayer
class_name UI
var knapp
var selectedMonkey
#var

func _ready():
	knapp = $Control/MarginContainer/VBoxContainer/HBoxContainer/Button
	


func _on_button_button_down():
	pass
	#get_parent().get_node("TileMap").
