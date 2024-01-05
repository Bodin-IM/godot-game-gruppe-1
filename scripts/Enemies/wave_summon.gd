extends Path2D

var rounds
var balloons

func _ready():
	balloons = {
		"red":{
			"speed":1,
			"dmg":1,
			"frames":preload("res://Assets/bloon_sprite_frames/red_sprite_frames.tres"),
			"type":"red",
			"next_type":""
		},
		"blue":{
			"speed":2,
			"dmg":2,
			"frames":preload("res://Assets/bloon_sprite_frames/blue_sprite_frames.tres"),
			"type":"blue",
			"next_type":"red"
		},
		"green":{
			"speed":3,
			"dmg":4,
			"frames":preload("res://Assets/bloon_sprite_frames/green_sprite_frames.tres"),
			"type":"green",
			"next_type":"blue"
		},
		"yellow":{
			"speed":4,
			"dmg":8,
			"frames":preload("res://Assets/bloon_sprite_frames/yellow_sprite_frames.tres"),
			"type":"yellow",
			"next_type":"green"
		},
		"pink":{
			"speed":5,
			"dmg":16,
			"frames":preload("res://Assets/bloon_sprite_frames/pink_sprite_frames.tres"),
			"type":"pink",
			"next_type":"yellow"
		},
	}
	
	rounds = [
	[
	{"type":balloons.red, "amount":1}, 
	{"type":balloons.blue, "amount":1},
	{"type":balloons.green, "amount":1}, 
	{"type":balloons.yellow, "amount":1}, 
	{"type":balloons.pink, "amount":1}, 
	],
	[
	{"type":balloons.red, "amount":3}, 
	{"type":balloons.blue, "amount":8},
	{"type":balloons.red, "amount":6}, 
	{"type":balloons.blue, "amount":3}, 
	{"type":balloons.red, "amount":2}, 
	],
	[
	{"type":balloons.red, "amount":3}, 
	{"type":balloons.blue, "amount":8},
	{"type":balloons.red, "amount":6}, 
	{"type":balloons.blue, "amount":3}, 
	{"type":balloons.red, "amount":2}, 
	],
	]



