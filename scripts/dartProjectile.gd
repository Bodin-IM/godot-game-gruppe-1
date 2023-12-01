extends Area2D

# Speed of movement
var speed = 1000
var parRotation
var popSound = preload("res://assets/pop.wav")
var audioplayer
var cols = 0
var maxCols = 1

func _ready():
	self.z_index = 1
	audioplayer = get_parent().get_node("AudioStreamPlayer2D")
	self.name = "dart"
	parRotation = get_parent().get_node("AnimatedSprite2D").rotation_degrees-100
	self.get_node("mainProj").rotation_degrees = parRotation

func _process(delta):
	#print(parRotation)
	var movement_vector = Vector2(1, 0).rotated(deg_to_rad(parRotation))
	position += movement_vector * speed * delta

func _on_projectile_area_entered(area):
	if area.is_in_group("Enemys"):
		audioplayer.stream = popSound
		audioplayer.play()
		cols = cols + 1
		if cols < 2:
			area.balloonHit()
			self.queue_free()
			
