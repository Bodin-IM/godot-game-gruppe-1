extends Area2D

var blackTransparent = Color(0.0, 0.0, 0.0,0.2) #(red,green,blue,transparency)
var redTransparent = Color(1.0,0,0,0.1) #(red,green,blue,transparency)
var amountOfObjects = 0
var placeable = true
var placed = false
var testInt = 10
var degs
var cooldownOff = false

var audioPlayer
var animatedSprite
var meshNode
var attackCooldown
var rangeCol
var testVar = 0
var clicked = false
var projSpeed = 1000
var uiScript
var mouseInNode
var mainMap

var upgrades = {
	"left":[15,30], #range
	"right":[20,40], #projectile speed
	"names":{
		"l1":"Range Increase",
		"l2":"More Range",
		"r1":"Faster Shots",
		"r2":"FASTER"
	}
}

func _ready():
	mainMap = get_parent().get_parent()
	uiScript = get_parent().get_parent().get_node("UI")
	audioPlayer = $AudioStreamPlayer2D
	animatedSprite = $AnimatedSprite2D
	attackCooldown = $attackCooldown
	rangeCol = $rangeCol
	meshNode = $rangeCol/rangeMesh
	meshNode.modulate = blackTransparent
	attackCooldown.start()
	#rangeCol.scale = Vector2(2,2)
	#meshNode.scale = Vector2(20,20)

func _process(_delta):
	if placed:
		if clicked:meshNode.modulate.a = 0.2; mainMap.selectedMonkey = self
		else:meshNode.modulate.a = 0
		var nearest_body
		var arr = getEnemysInRange()
		if arr.size() > 0:
			nearest_body = getFurthestBody(arr)
		if nearest_body:
			rotate_towards(nearest_body.global_position)
			if cooldownOff:
				cooldownOff = false
				attackCooldown.start()
				start_attack()
	
	if !placed: self.global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("normalClick"):
		if placeable:
			audioPlayer.stream = preload("res://assets/tower_place.wav")
			audioPlayer.play()
			placed = true
			placeable = false

func setRangeToNull():
	meshNode.scale = Vector2(1,1)
	rangeCol.get_node("range").scale = Vector2(1,1)

func testUpgrade(upgradeValue):
	if upgradeValue == "l1":
		setRangeToNull()
		var scaleVal = 1+(upgrades.left[0]/100)
		scale = Vector2(scaleVal, scaleVal)
		meshNode.scale = Vector2(scaleVal, scaleVal)
	elif upgradeValue == "l2":
		setRangeToNull()
		var scaleVal = 1+(upgrades.left[1]/100)
		scale = Vector2(scaleVal, scaleVal)
		meshNode.scale = Vector2(scaleVal, scaleVal)
	elif upgradeValue == "r1":
		projSpeed = 1000+(upgrades.right[0]*10)
	elif upgradeValue == "r2":
		projSpeed = 1000+(upgrades.right[1]*10)
	rangeCol.get_node("range").scale = Vector2(30,30)

func getEnemysInRange():
	var objects = rangeCol.get_overlapping_areas()
	var arr = []
	for key in objects:
		if key.is_in_group("Enemys"):
			arr.push_front(key)
	return arr

func _on_area_entered(body):
	if !placed:
		if body.is_in_group("mainCol") || body.is_in_group("path_hitbox"):
			amountOfObjects = amountOfObjects+1
			meshNode.modulate = redTransparent
			placeable = false
			print("Object colliding")

func _on_area_exited(body):
	if !placed:
		if body.is_in_group("mainCol") || body.is_in_group("path_hitbox"):
			amountOfObjects = amountOfObjects-1
			if(amountOfObjects < 1):
				meshNode.modulate = blackTransparent
				placeable = true
				print("Placeable")
				amountOfObjects = 0

func get_nearest_body(bodies):
	var nearest_distance = 0
	var nearest_body = null

	for body in bodies:
		if body.is_in_group("Enemys"): 
			var distance = position.distance_to(body.position)
			if distance > nearest_distance:
				nearest_distance = distance
				nearest_body = body
	return nearest_body

func getFurthestBody(bodies):
	var furthestBody
	var highestProg = 0
	for body in bodies:
		if body.is_in_group("Enemys"):
			var bodyProg = body.progress
			if bodyProg > highestProg:
				furthestBody = body
	return furthestBody

func rotate_towards(target_position):
	if animatedSprite:
		var direction = (target_position - animatedSprite.global_position).normalized()
		var angle_rad = atan2(direction.y, direction.x)
		var angle_deg = rad_to_deg(angle_rad)
		animatedSprite.rotation_degrees = angle_deg+90
		degs = animatedSprite.rotation_degrees
	else:
		print("AnimatedSprite2D not found.")

func can_shoot():
	if attackCooldown.time_left > 0:
		return false
	else:
		return true

func _on_range_col_area_entered(body):
	if placed:
		if body.is_in_group("Enemys"):
			pass

	
func start_attack():
	if placed:
		var nearestbodyset = false
		var arr = getEnemysInRange()
		if arr.size() > 0:
			nearestbodyset = true
		if nearestbodyset:
			attack()
		else:attackCooldown.stop();cooldownOff=true

func attack():
	var dart = preload("res://scenes/dart_projectile.tscn")
	var instance = dart.instantiate()
	instance.speed = projSpeed
	self.add_child(instance)
	#print(get_children())


func _on_attack_cooldown_timeout():
	start_attack()


func _on_main_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			clicked = true
			mainMap.changeButtonText(upgrades.names.l1, upgrades.names.r1)
			mainMap.focusMonkey(self, upgrades)
