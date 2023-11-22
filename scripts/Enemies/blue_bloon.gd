extends Area2D
var temp_global_money
var temp_global_hit_enemy
var anim
var dying
var speed = 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	anim = $AnimatedSprite2D

func _process(delta):
	if dying == true:
		anim.play("pop")
	else:
		anim.play("idle")
		
	if Input.is_action_just_pressed("ui_up"): #Testing instence remove later
		$poped.start()


func _on_hitbox_body_entered(body):
	if body.is_in_group("darts"):
		temp_global_hit_enemy = true
		dying = true
		$poped.start()


func _on_poped_timeout():
	var ballon = preload("res://scenes/enemys/red_bloon.tscn")
	var instance = ballon.instantiate()
	instance.position = position
	get_parent().get_child().add_child(instance)
	self.queue_free()
	$poped.stop()
