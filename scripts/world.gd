extends Node2D

var target_resolution = Vector2(1920, 1080)  # Set your target resolution here

func _ready():
	# Calculate the aspect ratio of the target resolution
	var target_aspect_ratio = target_resolution.x / target_resolution.y
	
	# Get the current screen size
	var screen_size = DisplayServer.window_get_size()
	
	# Calculate the aspect ratio of the current screen size
	var screen_aspect_ratio = screen_size.x / screen_size.y
	
	# Calculate the scaling factor based on the aspect ratios
	var scale_factor = Vector2.ONE
	
	if target_aspect_ratio > screen_aspect_ratio:
		# If the target aspect ratio is wider, scale based on the width
		scale_factor.x = screen_size.x / target_resolution.x
		scale_factor.y = scale_factor.x
	else:
		# If the target aspect ratio is taller, scale based on the height
		scale_factor.y = screen_size.y / target_resolution.y
		scale_factor.x = scale_factor.y
	
	# Apply the scaling factor to the root node
	scale = scale_factor
