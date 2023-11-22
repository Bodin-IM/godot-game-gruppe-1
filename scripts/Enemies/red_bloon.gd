extends Area2D
var temp_global_money
var anim
var damaged
var speed = 3
var path_follow

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	path_follow = get_parent()
	anim = $AnimatedSprite2D
	anim.play("Initial_color")

func _physics_process(delta):
	path_follow.set_progress(path_follow.get_progress() + speed + delta)


func _on_hitbox_body_entered(body):
	if body.is_in_group("Dart"):
		self.queue_free()
