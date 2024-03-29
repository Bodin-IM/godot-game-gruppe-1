extends Node2D

var money = 200
var health = 100

var dartprice = 100
var tackprice = 200
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
var selectedMonkey = ''
var ui
var up1
var up2
var infoSlot
var placing = false
var waitTime = 1
var selectedUpgrade = {"monkey":"","upgrades":[]}
var pathRoot
var spawnTimer

func _ready():
	path = $TileMap/path/Path2D
	pathRoot = $TileMap/path
	spawnTimer = $TileMap/path/Spawn_CD
	ui = get_node("UI/Control")
	up1 = ui.get_node("Upgrade_tab/HBoxContainer/knappL/venstreKnapp")
	up2 = ui.get_node("Upgrade_tab/HBoxContainer/knappR/høyreKnapp")
	infoSlot = ui.get_node("Upgrade_tab/HBoxContainer/HBoxContainer/label/infoLabel")

func _process(_delta):
	$UI/money.text = str(money)
	checkHealth()
	get_node('UI').get_node('healthlabel').text = str(health)
	print($TileMap/path/Path2D.get_child_count())
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
			selectedUpgrade.monkey = null
	if Input.is_action_just_pressed("fKeyPressed"):
		startRound()
	if Input.is_action_just_pressed("w"):
		if money > tackprice-1:
			money-=tackprice;selectedMonkey='tack';checkPlacement('tack')
	if Input.is_action_just_pressed("q"):
		if money > dartprice-1:
			money-=dartprice;selectedMonkey='dart';checkPlacement('dart')
		
func checkPlacement(towerType):
	if !placing:
		placing = true
		var towersc = preload("res://scenes/tower.tscn")
		var instance = towersc.instantiate()
		var script
		if (selectedMonkey == 'dart'):
			script = ResourceLoader.load("res://scripts/towers/dart/dart_script.gd")
			instance.set_script(script)
		elif (selectedMonkey == 'tack'):
			script = ResourceLoader.load("res://scripts/towers/tack/tack_script.gd")
			instance.set_script(script)
		$TileMap.add_child(instance)
	
func checkHealth():
	if health < 1:
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")

func startRound():
	if path.get_child_count() < 1:
		$UI/Label.text = 'Current Round: ' + str(current_round+2)
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
	
func initUpgrade(side):
	if selectedUpgrade.monkey == null: return
	var monkey = selectedUpgrade.monkey
	if side == "L":
		monkey.testUpgrade(selectedUpgrade.upgrades[0])
	elif side == "R":
		monkey.testUpgrade(selectedUpgrade.upgrades[1])
	
func focusMonkey(monkey, upgrades):
	#print("focusing monkey: ");print(monkey);print(upgrades)
	hideAllRangeShapes(monkey)
	var lUpgrade = "l1"
	if upgrades.l1.activated: lUpgrade = "l2"
	var rUpgrade = "r1"
	if upgrades.r1.activated: rUpgrade = "r2"
	selectedUpgrade.monkey = monkey
	selectedUpgrade.upgrades = [lUpgrade,rUpgrade]
	changeButtonText(upgrades[lUpgrade].name,upgrades[rUpgrade].name,upgrades.Description)
	
func round_summon():
	if roundReady:
		pathRoot.get_node("Spawn_CD").wait_time = waitTime
		waitTime = waitTime*0.9
		roundReady = false
		current_wave = 0
		current_round += 1
		wave_summon()
		
func wave_summon():
	var wave = path.rounds[current_round][current_wave]
	var speed = wave.type.speed
	var dmg = wave.type.dmg
	var type = wave.type.type
	var frame = wave.type.frames
	var next_type = wave.type.next_type
	var moneyrewarded = wave.type.moneyRewarded
	
	for i in range(wave.amount):
		spawn_ballon(frame, speed, dmg, type, next_type, false, moneyrewarded)
		spawnTimer.start()
		await(spawnTimer.timeout)
	if path.rounds[current_round].size() > current_wave + 1:
		current_wave += 1
		wave_summon()
	else:
		roundReady = true
		get_node('UI').roundActive = false
		ui.get_node("tower_tab/startKnapp/Button").text = "Start round"
	

func spawn_ballon(frames, speed, damage, type, next_type, newBalloon,money1):
		print("spawned")
		var instance = bloon_scene.instantiate()
		instance.set_values(frames, speed, damage, type, next_type,money1)
		instance.scale = Vector2(0.2,0.2)
		var path_follow_new = PathFollow2D.new()
		if newBalloon: path_follow_new.progress = testProg
		path_follow_new.set_rotates(false)
		path_follow_new.set_loop(false)
		path.add_child(path_follow_new)
		path_follow_new.add_child(instance) 
		
func newBalloon(next_bln, pos):
	testProg = pos
	balloons = path.balloons
	print(next_bln)
	spawn_ballon(balloons[next_bln].frames, balloons[next_bln].speed, balloons[next_bln].dmg, next_bln, balloons[next_bln].next_type, true,balloons[next_bln].moneyRewarded)
