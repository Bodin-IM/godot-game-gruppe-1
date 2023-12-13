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
var infoSlot
var placing = false
var waitTime = 1

func _ready():
	path = get_node("TileMap/Node2D/Path2D")
	ui = get_node("UI/Control")
	up1 = ui.get_node("Upgrade_tab/HBoxContainer/knappL/Button")
	up2 = ui.get_node("Upgrade_tab/HBoxContainer/knappR/Button")
	infoSlot = ui.get_node("Upgrade_tab/HBoxContainer/HBoxContainer/label/infoLabel")

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
	if Input.is_action_just_pressed("normalClick"):
		var towerNodes = get_node("TileMap").get_children()
		var towerFound = false
		for node in towerNodes:
			if node.is_in_group("towers") && node.mouseInside:
				node.clicked = true
				focusMonkey(node, node.upgrades)
				towerFound = true
				break
			elif node.is_in_group("ui"):
				towerFound = true
				break
		if !towerFound:
			hideAllRangeShapes(null)
			infoSlot.text = "info about towers"
			up1.text = "upgrade 1"
			up2.text = "upgrade 2"
	if Input.is_action_just_pressed("fKeyPressed"):
		startRound()
	checkPlacement()
	
func checkPlacement():
	if Input.is_action_just_pressed("q"):
		if !placing:
			placing = true
			$TileMap.add_child(preload("res://scenes/dart.tscn").instantiate())	
	
func startRound():
	if path.get_child_count() < 1:
		ui.get_node("tower_tab/startKnapp/Button").text = "Round Active"
		round_summon()
		
func changeButtonText(b1,b2,desc):
	if b1.length() > 0: up1.text = b1
	if b2.length() > 0: up2.text = b2
	if desc.length() > 0: infoSlot.text = desc
	
func hideAllRangeShapes(monkey):
	var allNodes = get_node("TileMap").get_children()
	var arr = []
	for child in allNodes:
		if child.is_in_group("towers"):
			arr.push_front(child)
	if arr.size() > 0:
		for node in arr:
			node.clicked = false
	if !monkey == null:
		monkey.clicked = true
	
func focusMonkey(monkey, upgrades):
	#print("focusing monkey: ");print(monkey);print(upgrades)
	hideAllRangeShapes(monkey)
	var lUpgrade = "l1"
	if upgrades.l1.activated: lUpgrade = "l2"
	var rUpgrade = "r1"
	if upgrades.r1.activated: rUpgrade = "r2"
	changeButtonText(upgrades[lUpgrade].name,upgrades[rUpgrade].name,upgrades.Description)
	
func round_summon():
	if roundReady:
		$TileMap/Node2D/Spawn_CD.wait_time = waitTime
		waitTime = waitTime*0.9
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
		$TileMap/Node2D/Spawn_CD.start()
		await($TileMap/Node2D/Spawn_CD.timeout)
	if rounds[current_round].size() > current_wave + 1:
		current_wave += 1
		wave_summon()
	else:
		roundReady = true
		get_node('UI').roundActive = false
		ui.get_node("tower_tab/startKnapp/Button").text = "Start round"
	

func spawn_ballon(frames, speed, damage, type, newBalloon):
		print("spawned")
		var instance = bloon_scene.instantiate()
		instance.set_values(frames, speed, damage, type)
		instance.scale = Vector2(0.2,0.2)
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
	
