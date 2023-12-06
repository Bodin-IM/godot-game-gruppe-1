extends Node2D
var path
var rand_bloon

var current_wave = -1
var waves
var rounds
var current_round = -1
var red_values
var blue_values
var roundReady = true
var red_sprite_frames = preload("res://Assets/bloon_sprite_frames/red_sprite_frames.tres")
var blue_sprite_frames = preload("res://Assets/bloon_sprite_frames/blue_sprite_frames.tres")
var bloon_scene = preload("res://scenes/enemys/Red_bloon.tscn")
var myObj
var balloons




# Called when the node enters the scene tree for the first time.
func _ready():
	path = get_node("TileMap/Node2D/Path2D")
	balloons = {
		"red":{
			"speed":2,
			"dmg":1,
			"frames":preload("res://Assets/bloon_sprite_frames/red_sprite_frames.tres"),
			"group":"red_bloon"
		},
		"blue":{
			"speed":3,
			"dmg":2,
			"frames":preload("res://Assets/bloon_sprite_frames/blue_sprite_frames.tres"),
			"group":"blue_bloon"
		},
	}
	
	rounds = [
	[
	{"type":balloons.red, "amount":3}, 
	{"type":balloons.blue, "amount":8},
	{"type":balloons.red, "amount":6}, 
	{"type":balloons.blue, "amount":3}, 
	{"type":balloons.red, "amount":2}, 
	],
	[
	{"type":balloons.red, "amount":3}, 
	{"type":balloons.blue, "amount":8},
	{"type":balloons.red, "amount":6}, 
	{"type":balloons.blue, "amount":3}, 
	{"type":balloons.red, "amount":2}, 
	],
	[
	{"type":balloons.red, "amount":3}, 
	{"type":balloons.blue, "amount":8},
	{"type":balloons.red, "amount":6}, 
	{"type":balloons.blue, "amount":3}, 
	{"type":balloons.red, "amount":2}, 
	]
	]
	

func _process(_delta):
	if Input.is_action_just_pressed("fKeyPressed"):
		if roundReady:
			roundReady = false
			current_round += 1
			round_summon()
	
func round_summon():
	for wave in rounds[current_round]:
		wave_summon()
		$TileMap/Node2D/Spawn_CD.start()
		await($TileMap/Node2D/Spawn_CD.timeout)
	current_wave = -1
	roundReady = true
		
func wave_summon():
	var wave = rounds[current_round][current_wave]
	var speed = wave.type.speed
	var dmg = wave.type.dmg
	var group = wave.type.group
	
	for i in range(wave.amount):
		spawn_ballon(wave.type.frames, speed, dmg, group)
		$TileMap/Node2D/Spawn_CD.start()
		await($TileMap/Node2D/Spawn_CD.timeout)
	if rounds[current_round].size() > current_wave + 1:
		current_wave += 1
		wave_summon()
	

func spawn_ballon(frames, speed, damage, group):
		print("spawned")
		var instance = bloon_scene.instantiate()
		instance.set_values(frames, speed, damage)
		instance.add_to_group(group)
		instance.scale = Vector2(0.2,0.2)
		var path_follow_new = PathFollow2D.new()
		path.add_child(path_follow_new)
		path_follow_new.add_child(instance)
		
