extends Area2D

var meshNode
var blackTransparent = Color(0.0, 0.0, 0.0,0.2) #(red,green,blue,transparency)
var redTransparent = Color(1.0,0,0,0.1) #(red,green,blue,transparency)
var amountOfObjects = 0
var placeable = true
var upgrades = {
	"hei":1
};


func _ready():
	meshNode = get_parent().get_node("rangeCol").get_node("rangeMesh")
	meshNode.modulate = blackTransparent
	print(upgrades)

func _process(_delta):
	pass

func isMainCol():
	pass

func _on_area_entered(body):
	if body.has_method("isMainCol"):
		amountOfObjects = amountOfObjects+1
		meshNode.modulate = redTransparent
		placeable = false
		print("Object colliding")

func _on_area_exited(body):
	if body.has_method("isMainCol"):
		amountOfObjects = amountOfObjects-1
		if(amountOfObjects < 1):
			meshNode.modulate = blackTransparent
			placeable = true
			print("Placeable")
			amountOfObjects = 0
