extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("key_f"):
		var ballon = preload("res://scenes/enemys/Green_bloon.tscn")
		var instance = ballon.instantiate()
		self.get_node("Path2D").get_node("PathFollow2D").add_child(instance)
