extends Path2D

var rounds
var balloons

func _ready():
	balloons = {
		"red":{
			"speed":1,
			"dmg":1,
			"moneyRewarded":1,
			"frames":preload("res://Assets/bloon_sprite_frames/red_sprite_frames.tres"),
			"type":"red",
			"next_type":""
		},
		"blue":{
			"speed":1.4,
			"dmg":2,
			"moneyRewarded":2,
			"frames":preload("res://Assets/bloon_sprite_frames/blue_sprite_frames.tres"),
			"type":"blue",
			"next_type":"red"
		},
		"green":{
			"speed":1.8,
			"dmg":3,
			"moneyRewarded":3,
			"frames":preload("res://Assets/bloon_sprite_frames/green_sprite_frames.tres"),
			"type":"green",
			"next_type":"blue"
		},
		"yellow":{
			"speed":3.2,
			"dmg":4,
			"moneyRewarded":4,
			"frames":preload("res://Assets/bloon_sprite_frames/yellow_sprite_frames.tres"),
			"type":"yellow",
			"next_type":"green"
		},
		"pink":{
			"speed":3.5,
			"dmg":5,
			"moneyRewarded":5,
			"frames":preload("res://Assets/bloon_sprite_frames/pink_sprite_frames.tres"),
			"type":"pink",
			"next_type":"yellow"
		},
		"black":{
			"speed":1.8,
			"dmg":11,
			"moneyRewarded":11,
			"frames":preload("res://Assets/bloon_sprite_frames/black_sprite_frames.tres"),
			"type":"black",
			"next_type":"pink"
		},
		"white":{
			"speed":2,
			"dmg":11,
			"moneyRewarded":12,
			"frames":preload("res://Assets/bloon_sprite_frames/white_sprite_frames.tres"),
			"type":"white",
			"next_type":"pink"
		},
		"zebra":{
			"speed":1.8,
			"dmg":23,
			"moneyRewarded":23,
			"frames":preload("res://Assets/bloon_sprite_frames/zebra_sprite_frames.tres"),
			"type":"white",
			"next_type":"white"
		},
		"rainbow":{
			"speed":2.2,
			"dmg":47,
			"moneyRewarded":47,
			"frames":preload("res://Assets/bloon_sprite_frames/rainbow_sprite_frames.tres"),
			"type":"rainbow",
			"next_type":"zebra"
		},
	}
	#Zebra img needs fixing later image on laptop pxlr
	rounds = [
	#Round 1
	[
	{"type":balloons.red, "amount":20}, 
	],
	#Round 2
	[
	{"type":balloons.red, "amount":30},
	],
	#Round 3
	[
	{"type":balloons.red, "amount":20}, 
	{"type":balloons.blue, "amount":5},
	],
	#Round 4
	[
	{"type":balloons.red, "amount":30}, 
	{"type":balloons.blue, "amount":15},
	],
	#Round 5
	[
	{"type":balloons.red, "amount":5}, 
	{"type":balloons.blue, "amount":25},
	],
	#Round 6
	[
	{"type":balloons.red, "amount":15}, 
	{"type":balloons.blue, "amount":15},
	{"type":balloons.green, "amount":4},
	],
	#Round 7
	[
	{"type":balloons.red, "amount":20}, 
	{"type":balloons.blue, "amount":25},
	{"type":balloons.green, "amount":5},
	],
	#Round 8
	[
	{"type":balloons.red, "amount":10}, 
	{"type":balloons.blue, "amount":20},
	{"type":balloons.green, "amount":5},
	], 
	#Round 9
	[
	{"type":balloons.red, "amount":10}, 
	{"type":balloons.blue, "amount":20},
	{"type":balloons.green, "amount":14},
	], 
	#Round 10
	[
	{"type":balloons.green, "amount":30},
	], 
	#Round 11
	[
	{"type":balloons.blue, "amount":102},
	], 
	#Round 12
	[
	{"type":balloons.red, "amount":10}, 
	{"type":balloons.blue, "amount":10},
	{"type":balloons.green, "amount":12},
	{"type":balloons.yellow, "amount":2},
	], 
	#Round 13
	[
	{"type":balloons.blue, "amount":15}, 
	{"type":balloons.green, "amount":10},
	{"type":balloons.yellow, "amount":5},
	], 
	#Round 14
	[
	{"type":balloons.red, "amount":100}, 
	{"type":balloons.green, "amount":23},
	{"type":balloons.yellow, "amount":4},
	], 
	#Round 15
	[
	{"type":balloons.red, "amount":50}, 
	{"type":balloons.blue, "amount":15},
	{"type":balloons.green, "amount":10},
	{"type":balloons.yellow, "amount":9},
	], 
	#Round 16
	[
	{"type":balloons.red, "amount":20}, 
	{"type":balloons.green, "amount":12},
	{"type":balloons.yellow, "amount":5},
	{"type":balloons.pink, "amount":3},
	], 
	#Round 17
	[
	{"type":balloons.green, "amount":20}, 
	{"type":balloons.yellow, "amount":8},
	{"type":balloons.pink, "amount":4},
	], 
	#Round 18
	[
	{"type":balloons.yellow, "amount":25}, 
	], 
	#Round 19
	[
	{"type":balloons.green, "amount":80}, 
	], 
	#Round 20
	[
	{"type":balloons.green, "amount":10}, 
	{"type":balloons.yellow, "amount":9}, 
	{"type":balloons.pink, "amount":7}, 
	], 
	#Round 21
	[
	{"type":balloons.black, "amount":6}, 
	],  
	#Round 22
	[
	{"type":balloons.pink, "amount":14}, 
	], 
	#Round 23
	[
	{"type":balloons.white, "amount":8}, 
	], 
	#Round 24
	[
	{"type":balloons.black, "amount":5}, 
	{"type":balloons.white, "amount":4}, 
	], 
	#Round 25
	[
	{"type":balloons.pink, "amount":23}, 
	{"type":balloons.zebra, "amount":4}, 
	], 
	#Round 26
	[
	{"type":balloons.red, "amount":120}, 
	{"type":balloons.blue, "amount":55},
	{"type":balloons.green, "amount":45}, 
	{"type":balloons.yellow, "amount":45}, 
	], 
	#Round 27
	[
	{"type":balloons.yellow, "amount":25}, 
	{"type":balloons.pink, "amount":24}, 
	], 
	#Round 28
	[
	{"type":balloons.zebra, "amount":12}, 
	], 
	#Round 29
	[
	{"type":balloons.black, "amount":25}, 
	{"type":balloons.white, "amount":28}, 
	], 
	#Round 30
	[
	{"type":balloons.yellow, "amount":140}, 
	{"type":balloons.zebra, "amount":5}, 
	], 
	#Round 30
	[
	{"type":balloons.pink, "amount":35}, 
	{"type":balloons.white, "amount":25}, 
	{"type":balloons.rainbow, "amount":5}, 
	], 
	#Round 30
	[
	{"type":balloons.pink, "amount":81}, 
	], 
	#Round 30
	[
	{"type":balloons.red, "amount":300},
	{"type":balloons.pink, "amount":50},
	{"type":balloons.black, "amount":20}, 
	{"type":balloons.white, "amount":27}, 
	{"type":balloons.zebra, "amount":10},
	{"type":balloons.rainbow, "amount":8},
	], 
	]



