extends Area2D
var temp_global_money
var temp_global_hit_enemy
var anim
var dying
var speed = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	anim = $AnimatedSprite2D

func _process(delta):
	if dying == true:
		anim.play("pop")
	else:
		anim.play("idle")


func _on_hitbox_body_entered(body):
	if body.is_in_group("darts"):
		temp_global_hit_enemy = true
		dying = true
		$poped.start()


func _on_poped_timeout():
	self.queue_free()
	$poped.stop()
