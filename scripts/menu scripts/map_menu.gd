extends Control



func _on_map_1_pressed():
	get_tree().change_scene_to_file("res://scenes/maps/map_1.tscn")


func _on_map_2_pressed():
	get_tree().change_scene_to_file("res://scenes/maps/map_2.tscn")


func _on_map_3_pressed():
	get_tree().change_scene_to_file("res://scenes/maps/map_3.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
