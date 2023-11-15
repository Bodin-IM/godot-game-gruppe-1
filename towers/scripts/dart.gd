extends Area2D


func _process(delta):
	print("hei")


func _on_placement_col_body_entered(body):
	if(body.is_in_group("path")):
		print("i path group")
