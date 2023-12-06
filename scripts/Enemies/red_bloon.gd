extends Area2D
var temp_global_money
var temp_global_life = 100
var anim
var damage = 1
var speed = 2
var path_follow
var progress = 0



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	path_follow = get_parent()
	anim = $AnimatedSprite2D
	path_follow.set_rotates(false)
	path_follow.set_loop(false)

func set_values(frames, set_speed, set_damage, group):
	$AnimatedSprite2D.sprite_frames = frames
	speed = set_speed
	damage = set_damage
	self.add_to_group(group)

func _physics_process(delta):
	path_follow.set_progress(path_follow.get_progress() + speed + delta)
	progress = progress + speed
	
	if path_follow.progress_ratio == 1.0:
		temp_global_life -= 1
		self.queue_free()

func balloonHit():
	self.queue_free()
