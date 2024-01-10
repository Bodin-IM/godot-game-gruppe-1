extends Control



func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), Settings.volume_level)
	

func _process(_delta):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), Settings.volume_level)
	


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")


func _on_h_slider_value_changed(value):
	
	Settings.volume_level = value
	print(Settings.volume_level)
	
	
