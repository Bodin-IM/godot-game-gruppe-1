extends Area2D

# Speed of movement
var speed = 1000
var parRotation
var popSound = preload("res://assets/pop.wav")
var audioplayer

func _ready():
	audioplayer = get_parent().get_node("AudioStreamPlayer2D")
	self.name = "dart"
	parRotation = get_parent().get_node("AnimatedSprite2D").rotation_degrees-100
	self.get_node("mainProj").rotation_degrees = parRotation

func _process(delta):
	# Move towards the parent node's rotation
	print(parRotation)
	var movement_vector = Vector2(1, 0).rotated(deg_to_rad(parRotation))
	position += movement_vector * speed * delta

func _on_projectile_area_entered(area):
	if area.is_in_group("Enemys"):
		audioplayer.stream = popSound
		audioplayer.play()
		self.queue_free()
		area.queue_free()
