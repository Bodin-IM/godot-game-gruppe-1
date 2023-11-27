extends Node2D
var path

# Called when the node enters the scene tree for the first time.
func _ready():
	path = get_node("Path2D")

func _process(_delta):
	if Input.is_action_just_pressed("key_f"):
		spawn_ballon()
	
func spawn_ballon():
	print("spawned")
	var bloon = load("res://scenes/enemys/red_bloon.tscn")
	var instance = bloon.instantiate()
	var path_follow_new = PathFollow2D.new()
	path.add_child(path_follow_new)
	path_follow_new.add_child(instance)
