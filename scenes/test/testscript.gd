extends Node2D


func _ready():
	var blankTower = preload("res://scenes/tower.tscn")
	var instance = blankTower.instantiate()
	var script = ResourceLoader.load("res://scripts/towers/dart/dart_script.gd")
	instance.set_script(script)
	
	self.add_child(instance)
	
func _process(delta):
	pass
