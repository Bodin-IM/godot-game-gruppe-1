extends Node2D

var path
var current_wave = -1
var waves
var rounds
var current_round = -1
var red_valuesl
var blue_values
var roundReady = true
var red_sprite_frames = preload("res://Assets/bloon_sprite_frames/red_sprite_frames.tres")
var blue_sprite_frames = preload("res://Assets/bloon_sprite_frames/blue_sprite_frames.tres")
var bloon_scene = preload("res://scenes/enemys/Red_bloon.tscn")
var balloons
var testProg = 0
var selectedMonkey
var ui
var up1
var up2

func _ready():
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), Settings.volume_level)
	#$AudioStreamPlayer2D.volume_db = Settings.volume_level
	print(Settings.volume_level)
	path = get_node("TileMap/path/Path2D")
	ui = get_node("UI/Control")
	up1 = ui.get_node("Upgrade_tab/HBoxContainer/knappL/Button")
	up2 = ui.get_node("Upgrade_tab/HBoxContainer/knappR/Button")
	#up1.text = selectedMonkey.upgrades.names.l1
	#up2.text = selectedMonkey.upgrades.names.r1
	balloons = {
		"red":{
			"speed":2,
			"dmg":1,
			"frames":preload("res://Assets/bloon_sprite_frames/red_sprite_frames.tres"),
			"type":"red"
		},
		"blue":{
			"speed":3,
			"dmg":2,
			"frames":preload("res://Assets/bloon_sprite_frames/blue_sprite_frames.tres"),
			"type":"blue"
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
	],
	]
	

func _process(_delta):
	if Input.is_action_just_pressed("fKeyPressed"):
		if path.get_child_count() < 1:
			round_summon()
			
func changeButtonText(b1,b2):
	if b1.length() > 1: up1.text = b1
	if b2.length() > 1: up2.text = b2
	
func hideAllRangeShapes():
	var allNodes = get_node("TileMap").get_children()
	var arr = []
	for child in allNodes:
		if child.is_in_group("towers"):
			arr.push_front(child)
	print(arr)
	if arr.size() > 0:
		for node in arr:
			node.clicked = false
			node.get_node("rangeCol").get_node("rangeMesh").modulate.a = 0	
	
func focusMonkey(monkey, upgrades):
	hideAllRangeShapes()
	print(monkey)
	print(upgrades)	
	
func round_summon():
	if roundReady:
		roundReady = false
		current_wave = -1
		current_round += 1
		wave_summon()
		
func wave_summon():
	var wave = rounds[current_round][current_wave]
	var speed = wave.type.speed
	var dmg = wave.type.dmg
	var type = wave.type.type
	
	for i in range(wave.amount):
		spawn_ballon(wave.type.frames, speed, dmg, type, false)
		$TileMap/path/Spawn_CD.start()
		await($TileMap/path/Spawn_CD.timeout)
	if rounds[current_round].size() > current_wave + 1:
		current_wave += 1
		wave_summon()
	else:
		roundReady = true
	

func spawn_ballon(frames, speed, damage, type, newBalloon):
		print("spawned")
		var instance = bloon_scene.instantiate()
		instance.set_values(frames, speed, damage, type)
		instance.scale = Vector2(0.35,0.35)
		var path_follow_new = PathFollow2D.new()
		if newBalloon: path_follow_new.progress = testProg
		path_follow_new.set_rotates(false)
		path_follow_new.set_loop(false)
		path.add_child(path_follow_new)
		path_follow_new.add_child(instance)
		
func newBalloon(type, pos):
	testProg = pos
	if type == "red":
		spawn_ballon(balloons.red.frames, balloons.red.speed, balloons.red.dmg, type, true)
	