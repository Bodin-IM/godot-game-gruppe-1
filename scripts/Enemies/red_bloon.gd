extends Area2D
var temp_global_money
var temp_global_life = 100
var anim
var damage = 1
var speed = 2
var path_follow
var progress = 0
var balloonType = ""
var mainMap

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	mainMap = get_parent().get_parent().get_parent().get_parent().get_parent()
	path_follow = get_parent()
	anim = $AnimatedSprite2D
	path_follow.set_rotates(false)
	path_follow.set_loop(false)

func set_values(frames, set_speed, set_damage, type):
	$AnimatedSprite2D.sprite_frames = frames
	speed = set_speed
	damage = set_damage
	balloonType = type

func _physics_process(delta):
	path_follow.set_progress(path_follow.get_progress() + speed + delta)
	progress = progress + speed
	#print(balloonType)
	
	if path_follow.progress_ratio == 1.0:
		temp_global_life -= 1
		removeSelf()
	if Input.is_action_just_pressed("ui_up"): #Testing instance remove later
		$popped.start()

func balloonHit():
	if balloonType == "red":
		removeSelf()
	elif balloonType == "blue":
		mainMap.newBalloon("red", get_parent().progress)
		removeSelf()

func removeSelf():
	get_parent().queue_free()
	self.queue_free()
