extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var bombaclat = preload("res://music/bombaclat.mp3")
	$AudioStreamPlayer2D.stream = bombaclat
	$AudioStreamPlayer2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
