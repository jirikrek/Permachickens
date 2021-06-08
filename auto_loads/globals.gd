tool
extends Node

var game_o_clock := GameOClock.new()
var random := RandomNumberGenerator.new()

func _ready():
	add_child(game_o_clock)
	random.randomize()
