extends Area2D

var meshNode
var blackTransparent = Color(0.0, 0.0, 0.0,0.2) #(red,green,blue,transparency)
var redTransparent = Color(1.0,0,0,0.1) #(red,green,blue,transparency)
var amountOfObjects = 0
var placeable = true
var placed = false
var audioPlayer
var testInt = 10
var degs
var attackCooldown
var cooldownOff = false

func _ready():
	audioPlayer = get_parent().get_node("AudioStreamPlayer2D")
	meshNode = get_parent().get_node("rangeCol").get_node("rangeMesh")
	meshNode.modulate = blackTransparent
	attackCooldown = get_parent().get_node("attackCooldown")
	attackCooldown.start()

func _process(_delta):
	if placed:
		var nearest_body
		var arr = getEnemysInRange()
		if arr.size() > 0:
			nearest_body = get_nearest_body(arr)
		if nearest_body:
			rotate_towards(nearest_body.position)
			if cooldownOff:
				cooldownOff = false
				attackCooldown.start()
				start_attack()
	
	if !placed: get_parent().global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("normalClick"):
		if placeable:
			audioPlayer.stream = preload("res://assets/tower_place.wav")
			audioPlayer.play()
			placed = true

func getEnemysInRange():
	var objects = get_parent().get_node("rangeCol").get_overlapping_areas()
	var arr = []
	for key in objects:
		if key.is_in_group("Enemys"):
			arr.push_front(key)
	return arr

func _on_area_entered(body):
	if !placed:
		if body.is_in_group("mainCol"):
			amountOfObjects = amountOfObjects+1
			meshNode.modulate = redTransparent
			placeable = false
			print("Object colliding")

func _on_area_exited(body):
	if !placed:
		if body.is_in_group("mainCol"):
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
		var distance = position.distance_to(body.position)
		if distance > nearest_distance:
			nearest_distance = distance
			nearest_body = body

	return nearest_body

func rotate_towards(target_position):
	var animated_sprite = get_parent().get_node("AnimatedSprite2D")  # Adjust the node name as needed

	if animated_sprite:
		var direction = (target_position - animated_sprite.global_position).normalized()
		var angle_rad = atan2(direction.y, direction.x)
		var angle_deg = rad_to_deg(angle_rad)
		animated_sprite.rotation_degrees = angle_deg+90
		var degs = animated_sprite.rotation_degrees
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

func _on_attack_cooldown_timeout():
	start_attack()
	
func start_attack():
	if placed:
		var doAttack = false
		var nearest_body
		var nearestbodyset = false
		var arr = getEnemysInRange()
		if arr.size() > 0:
			nearest_body = get_nearest_body(arr)
			nearestbodyset = true
		if nearestbodyset:
			attack(nearest_body)
		else:attackCooldown.stop();cooldownOff=true

func attack(body):
	var dart = preload("res://scenes/dart_projectile.tscn")
	var instance = dart.instantiate()
	get_parent().add_child(instance)
	print(get_parent().get_children())
