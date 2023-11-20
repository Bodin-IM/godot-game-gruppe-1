extends Area2D
var temp_global_money
var anim

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	anim = $AnimatedSprite2D

func _process(delta):
	pass
	
	
	




func _on_hitbox_body_entered(body):
	if body.is_in_group("darts"):
		anim.play('pop')
	
