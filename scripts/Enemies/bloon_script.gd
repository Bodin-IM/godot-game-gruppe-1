extends Area2D
var temp_global_money
var temp_global_life = 100
var anim
var damage
var speed
var path_follow
var progress = 0
var balloonType = ""
var mainMap
var next_bln
var moneyAmount

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	mainMap = get_parent().get_parent().get_parent().get_parent().get_parent()
	path_follow = get_parent()
	anim = $AnimatedSprite2D
	path_follow.set_rotates(false)
	path_follow.set_loop(false)
	#print(next_bln)

func set_values(frames, set_speed, set_damage, type, next_type,money):
	$AnimatedSprite2D.sprite_frames = frames
	speed = set_speed
	damage = set_damage
	balloonType = type
	next_bln = next_type
	moneyAmount = money

func _physics_process(delta):
	path_follow.set_progress(path_follow.get_progress() + speed + delta)
	progress = progress + speed
	
	if path_follow.progress_ratio == 1.0:
		mainMap.health -= damage
		removeSelf()
	if Input.is_action_just_pressed("ui_up"): #Testing instance remove later
		$popped.start()

func balloonHit():
	if balloonType == "red":
		givemoney()
		removeSelf()
	else:
		mainMap.newBalloon(next_bln, get_parent().progress)
		givemoney()
		removeSelf()

func removeSelf():
	get_parent().queue_free()
	self.queue_free()
	
func givemoney():
	print(moneyAmount)
	mainMap.money += moneyAmount
