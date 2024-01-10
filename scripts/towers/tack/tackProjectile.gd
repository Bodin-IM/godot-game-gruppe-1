extends Area2D

# Speed of movement
var speed = 500
var rotering
var popSound = preload("res://assets/pop.wav")
var audioplayer
var cols = 0
var maxCols = 1
var rotationdegrees

func _ready():
	self.z_index = 1
	audioplayer = get_parent().get_node("AudioStreamPlayer2D")
	self.name = "tack"
	$AnimatedSprite2D.rotation_degrees = rotering+135

func _process(delta):
	var movement_vector = Vector2(1, 0).rotated(deg_to_rad(rotering))
	position += movement_vector * speed * delta

func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemys"):
		audioplayer.stream = popSound
		audioplayer.play()
		cols = cols + 1
		if cols < 2:
			area.balloonHit()
			self.queue_free()
