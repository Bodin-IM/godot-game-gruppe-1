extends Node2D

func _ready():
	# Connect signals
	$Area2D.connect("area_entered", self, "_on_area_entered")
	$Area2D.connect("area_exited", self, "_on_area_exited")

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		# Handle the entering of an enemy
		# You can access the position of the enemy using `area.position`
		rotate_towards(area.position)

func _on_area_exited(area):
	if area.is_in_group("enemy"):
		pass

func rotate_towards(target_position):
	var direction = (target_position - position).normalized()
	var angle = atan2(direction.y, direction.x)
	rotation = angle
