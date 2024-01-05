extends Control




func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/maps/map_1.tscn")




func _on_quit_pressed():
	get_tree().quit()


func _on_options_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")
