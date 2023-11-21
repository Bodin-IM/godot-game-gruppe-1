extends Area2D
var temp_global_money
var temp_global_hit_enemy
var anim
var dying
var speed = 3




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	anim = $AnimatedSprite2D
	

func _process(delta):
	pass
	
	if dying == true:
		anim.play("pop")
	else:
		anim.play("idle")
	
	if Input.is_action_pressed("key_E"):
		var red_bloon_instance_1 = preload("res://scenes/enemys/red_baloon.tscn").instance()
		red_bloon_instance_1.position = position + Vector2(0, 0)  # Adjust positions as needed
		get_parent().add_child(red_bloon_instance_1)




func _on_hitbox_body_entered(body):
	if body.is_in_group("darts"):
		temp_global_hit_enemy = true
		$poped.start()


func _on_poped_timeout():
	self.queue_free()
	var red_bloon_instance_1 = preload("res://scenes/enemys/red_baloon.tscn").instance()
	red_bloon_instance_1.position = position + Vector2(0, 0)  # Adjust positions as needed
	get_parent().add_child(red_bloon_instance_1)
	$poped.stop()
