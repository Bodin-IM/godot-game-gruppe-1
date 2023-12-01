extends Node2D
var path
var rand_bloon

var current_wave = -1
var waves
var red_values
var blue_values

var red_sprite_frames = preload("res://Assets/bloon_sprite_frames/red_sprite_frames.tres")
var blue_sprite_frames = preload("res://Assets/bloon_sprite_frames/blue_sprite_frames.tres")
var bloon_scene = preload("res://scenes/enemys/Red_bloon.tscn")
var myObj





# Called when the node enters the scene tree for the first time.
func _ready():
	path = get_node("TileMap/Node2D/Path2D")
	
	red_values = {"speed":2,"dmg":3.5}
	blue_values = {"speed":4,"dmg":10}
	waves = [
	{"type":red_sprite_frames, "amount":3, "vals":red_values}, 
	{"type":blue_sprite_frames, "amount":8, "vals":blue_values},
	]

func _process(_delta):
	if Input.is_action_just_pressed("fKeyPressed"):
		current_wave += 1
		wave_summon()
		$TileMap/Node2D/Spawn_CD.start()
		await($TileMap/Node2D/Spawn_CD.timeout)
	
func spawn_ballon(frames, speed, damage):
		print("spawned")
		var instance = bloon_scene.instantiate()
		instance.set_values(frames, speed, damage)
		instance.scale = Vector2(0.2,0.2)
		var path_follow_new = PathFollow2D.new()
		path.add_child(path_follow_new)
		path_follow_new.add_child(instance)
		
		
func wave_summon():
	var wave = waves[current_wave]
	var speed = waves[current_wave].vals.speed
	var dmg = waves[current_wave].vals.dmg
	
	for i in range(wave.amount):
		spawn_ballon(wave.type, speed, dmg)
		$TileMap/Node2D/Spawn_CD.start()
		await($TileMap/Node2D/Spawn_CD.timeout)
	if waves.size() > current_wave + 1:
		current_wave += 1
		wave_summon()
	
