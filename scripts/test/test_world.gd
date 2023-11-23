extends Node2D
var path_follow

# Called when the node enters the scene tree for the first time.
func _ready():
	path_follow = get_node("Path2D/PathFollow2D")

func _process(_delta):
	if Input.is_action_just_pressed("key_f"):
		spawn_ballon()
	
func spawn_ballon():
	print("spawned")
	var ballon = preload("res://scenes/enemys/red_bloon.tscn")
	var instance = ballon.instantiate()
	path_follow.add_child(instance)
