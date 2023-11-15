extends CollisionShape2D

func _ready():
	# Create a new ShaderMaterial
	var shader_material = ShaderMaterial.new()

	# Load the shader script
	shader_material.shader = preload("res://shaders/dart.gdshader")

	# Assign the ShaderMaterial to the CollisionShape2D
	material = shader_material
