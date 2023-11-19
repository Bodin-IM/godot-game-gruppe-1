extends Area2D


func _process(_delta):
	pass
	#self.global_position = get_global_mouse_position()

func _on_placement_col_body_entered(body):
	if(body.is_in_group("path")):
		var new_color = Color(1.0, 1.0, 1.0, 1.0)
		material.set_shader_param("color", new_color)
