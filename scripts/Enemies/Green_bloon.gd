extends Area2D
var temp_global_money
var temp_global_life = 100
var anim
var damage = 3
var speed = 3.6
var path_follow

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	path_follow = get_parent()
	anim = $AnimatedSprite2D
	anim.play("Initial_color")
	path_follow.set_rotates(false)
	path_follow.set_loop(false)

func _physics_process(delta):
	path_follow.set_progress(path_follow.get_progress() + speed + delta)
	
	if path_follow.progress_ratio == 1.0:
		temp_global_life -= 1
		self.queue_free()
	if Input.is_action_just_pressed("ui_up"): #Testing instence remove later
		$poped.start()


func _on_hitbox_body_entered(body):
	if body.is_in_group("darts"):
		$poped.start()


func _on_poped_timeout():
	var ballon = preload("res://scenes/enemys/blue_bloon.tscn")
	var instance = ballon.instantiate()
	instance.position = position
	get_parent().add_child(instance)
	self.queue_free()
	$poped.stop()
