extends CanvasLayer
class_name UI
var knapp
var selectedMonkey
var roundActive = false

func _ready():
	knapp = $Control/MarginContainer/VBoxContainer/HBoxContainer/Button
	

func _on_button_button_down():
	if roundActive == false:
		roundActive = true
		get_parent().startRound()
