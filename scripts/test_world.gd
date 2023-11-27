extends Node2D
var hasSelectedItem = false
var dartMonkey_scene


func _ready():
	dartMonkey_scene = preload("res://scenes/dart.tscn")

func _on_timer_timeout():
	#spawn_ballon()
	pass
	
func _process(_delta):
	if Input.is_action_just_pressed("pressS"):
		spawn_ballon()
	if Input.is_action_just_pressed("e"):
		get_node("dart_monkey").testVar = 1
	
func spawn_ballon():
	print("spawned")
	var ballon = preload("res://scenes/test_enemy.tscn")
	var instance = ballon.instantiate()
	instance.position = Vector2(-25,560)
	self.add_child(instance)
