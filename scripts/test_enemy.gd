extends Area2D
var speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.global_position.x = self.global_position.x + speed
	if(self.global_position.x > 1000):
		self.queue_free()
