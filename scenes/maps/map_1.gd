extends Node2D
var path
var rand_bloon
var dart

# Called when the node enters the scene tree for the first time.
func _ready():
	path = get_node("TileMap/Node2D/Path2D")
	pickrando()
	dart = preload("res://scenes/dart.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("e"):
		var instance = dart.instantiate()
		get_node("TileMap").add_child(instance)
	if Input.is_action_just_pressed("fKeyPressed"):
		spawn_ballon()
	if Input.is_action_pressed("ui_down"):
		spawn_ballon()
		$TileMap/Node2D/Spawn_CD.start()
		await($TileMap/Node2D/Spawn_CD.timeout)
	
func spawn_ballon():
	for i in range(3):
		print("spawned")
		var instance = rand_bloon.instantiate()
		instance.scale = Vector2(0.2,0.2)
		var path_follow_new = PathFollow2D.new()
		path.add_child(path_follow_new)
		path_follow_new.add_child(instance)
		pickrando()
		$TileMap/Node2D/Spawn_CD.start()
		await($TileMap/Node2D/Spawn_CD.timeout)
		
func pickrando():
	var i = randi_range(1, 1)
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
