extends CanvasLayer
class_name UI
var knapp
var selectedMonkey
var roundActive = false
var map
var selectedTowerType = ''
var dartButton
var tackButton

func _ready():
	knapp = $Control/MarginContainer/VBoxContainer/HBoxContainer/Button
	map = get_parent()
	var dartimg = preload('res://Assets/dart_icon.png')
	var tackimg = preload('res://Assets/tack_tower.png')
	#dartimg.resize(80,80,1)
	#tackimg.resize(80,80,1)
	dartButton = $Control/tower_tab/HBoxContainer/Button
	tackButton = $Control/tower_tab/HBoxContainer/Button2
	dartButton.set_button_icon(dartimg)
	tackButton.set_button_icon(tackimg)

func _on_button_button_down():
	if roundActive == false:
		roundActive = true
		get_parent().startRound()

func _on_venstre_knapp_button_down():
	map.initUpgrade("L")

func _on_høyre_knapp_button_down():
	map.initUpgrade("R")

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
	
