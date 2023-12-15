extends Path2D

var path
var current_wave = -1
var waves
var rounds
var current_round = -1
var red_valuesl
var blue_values
var roundReady = true
var red_sprite_frames = preload("res://Assets/bloon_sprite_frames/red_sprite_frames.tres")
var blue_sprite_frames = preload("res://Assets/bloon_sprite_frames/blue_sprite_frames.tres")
var bloon_scene = preload("res://scenes/enemys/Red_bloon.tscn")
var balloons
var testProg = 0

func _ready():
	path = get_node("Node2D.")
	balloons = {
		"red":{
			"speed":2,
			"dmg":1,
			"frames":preload("res://Assets/bloon_sprite_frames/red_sprite_frames.tres"),
			"type":"red"
		},
		"blue":{
			"speed":3,
			"dmg":2,
			"frames":preload("res://Assets/bloon_sprite_frames/blue_sprite_frames.tres"),
			"type":"blue"
		},
	}
	
	rounds = [
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
	[
	{"type":balloons.red, "amount":3}, 
	{"type":balloons.blue, "amount":8},
	{"type":balloons.red, "amount":6}, 
	{"type":balloons.blue, "amount":3}, 
	{"type":balloons.red, "amount":2}, 
	],
	]



