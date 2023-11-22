extends Node2D

func _ready():
	$Timer.start()

func _on_timer_timeout():
	#spawn_ballon()
	pass
	
func _process(_delta):
	if Input.is_action_just_pressed("pressS"):
		spawn_ballon()
	
func spawn_ballon():
	print("spawned")
	var ballon = preload("res://scenes/test_enemy.tscn")
	var instance = ballon.instantiate()
	instance.position = Vector2(-25,560)
	self.add_child(instance)
