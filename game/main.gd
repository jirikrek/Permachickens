extends Node

var farmer: Farmer


# initialize child dependencies
func _enter_tree():
	farmer = $Level/Objects/Farmer
	$GUI.farmer = farmer


func _ready():
	Globals.game_o_clock.run()

