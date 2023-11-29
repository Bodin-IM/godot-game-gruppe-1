extends Node2D
var path
var rand_bloon

var image = preload("res://Assets/red_sprite_frames.tres")



# Called when the node enters the scene tree for the first time.
func _ready():
	
	path = get_node("Path2D")
	pickrando()

func _process(_delta):
	if Input.is_action_just_pressed("key_f"):
		spawn_ballon()
	if Input.is_action_pressed("ui_down"):
		spawn_ballon()
		$Spawn_CD.start()
		await($Spawn_CD.timeout)
	
func spawn_ballon():
	for i in range(3):
		print("spawned")
		var instance = rand_bloon.instantiate()
		instance.set_image(image)
		var path_follow_new = PathFollow2D.new()
		path.add_child(path_follow_new)
		path_follow_new.add_child(instance)
		pickrando()
		$Spawn_CD.start()
		await($Spawn_CD.timeout)
		
func pickrando():
	var i = randi_range(1, 6)
	if i == 1:
		rand_bloon = load("res://scenes/enemys/red_bloon.tscn")
		print("Red")
	elif i == 2:
		rand_bloon = load("res://scenes/enemys/blue_bloon.tscn")
		print("Blue")
	elif i == 3:
		rand_bloon = load("res://scenes/enemys/green_bloon.tscn")
		print("Green")
	elif i == 4:
		rand_bloon = load("res://scenes/enemys/yellow_bloon.tscn")
		print("Yellow")
	elif i == 5:
		rand_bloon = load("res://scenes/enemys/pink_bloon.tscn")
		print("Pink")
	elif i == 6:
		rand_bloon = load("res://scenes/enemys/armoured_bloon.tscn")
		print("Armoured")
	else:
		print("Error")
