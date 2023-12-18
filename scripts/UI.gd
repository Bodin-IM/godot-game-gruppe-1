extends CanvasLayer
class_name UI
var knapp
var selectedMonkey
var roundActive = false
var map

func _ready():
	knapp = $Control/MarginContainer/VBoxContainer/HBoxContainer/Button
	map = get_parent()

func _on_button_button_down():
	if roundActive == false:
		roundActive = true
		get_parent().startRound()

func _on_venstre_knapp_button_down():
	map.initUpgrade("L")

func _on_høyre_knapp_button_down():
	map.initUpgrade("R")
