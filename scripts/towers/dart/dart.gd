extends Area2D


func _process(_delta):
	self.global_position = get_global_mouse_position()