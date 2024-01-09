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
			"speed":1.4,
			"dmg":2,
			"frames":preload("res://Assets/bloon_sprite_frames/blue_sprite_frames.tres"),
			"type":"blue",
			"next_type":"red"
		},
		"green":{
			"speed":1.8,
			"dmg":3,
			"frames":preload("res://Assets/bloon_sprite_frames/green_sprite_frames.tres"),
			"type":"green",
			"next_type":"blue"
		},
		"yellow":{
			"speed":3.2,
			"dmg":4,
			"frames":preload("res://Assets/bloon_sprite_frames/yellow_sprite_frames.tres"),
			"type":"yellow",
			"next_type":"green"
		},
		"pink":{
			"speed":3.5,
			"dmg":5,
			"frames":preload("res://Assets/bloon_sprite_frames/pink_sprite_frames.tres"),
			"type":"pink",
			"next_type":"yellow"
		},
		"black":{
			"speed":1.8,
			"dmg":11,
			"frames":preload("res://Assets/bloon_sprite_frames/black_sprite_frames.tres"),
			"type":"black",
			"next_type":"pink"
		},
		"white":{
			"speed":2,
			"dmg":11,
			"frames":preload("res://Assets/bloon_sprite_frames/white_sprite_frames.tres"),
			"type":"white",
			"next_type":"pink"
		},
		"zebra":{
			"speed":1.8,
			"dmg":23,
			"frames":preload("res://Assets/bloon_sprite_frames/zebra_sprite_frames.tres"),
			"type":"white",
			"next_type":"white"
		},
		"rainbow":{
			"speed":2.2,
			"dmg":47,
			"frames":preload("res://Assets/bloon_sprite_frames/rainbow_sprite_frames.tres"),
			"type":"rainbow",
			"next_type":"zebra"
		},
	}
	
	rounds = [
	[
	{"type":balloons.red, "amount":1}, 
	{"type":balloons.blue, "amount":1},
	{"type":balloons.green, "amount":1}, 
	{"type":balloons.yellow, "amount":1}, 
	{"type":balloons.pink, "amount":1},
	{"type":balloons.black, "amount":1}, 
	{"type":balloons.white, "amount":1},
	{"type":balloons.zebra, "amount":1},
	{"type":balloons.rainbow, "amount":7},
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



