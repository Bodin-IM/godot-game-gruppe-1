extends Control




	




func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_h_slider_value_changed(value):
	
	Settings.volume_level = value
	print(Settings.volume_level)
	
	
