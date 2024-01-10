extends Control




func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/map_menu.tscn")




func _on_quit_pressed():
	get_tree().quit()


func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/settings.tscn")


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/tutorial.tscn")
