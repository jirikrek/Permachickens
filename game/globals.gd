#
# This is a global AutoLoad script / singleton.
# Must be added to ProjectSettings/AutoLoad
#

tool
extends Node

var game_o_clock := GameOClock.new()
var random := RandomNumberGenerator.new()

func _ready():
	add_child(game_o_clock)
	random.randomize()
