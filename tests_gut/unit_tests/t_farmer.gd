extends BaseOClockTest

var farmer_scene := load("res://game/farmer/farmer.tscn")
var farmer: Farmer

func before_each():
	.before_each()
	farmer = farmer_scene.instance()
	add_child(farmer)
	

func after_each():
	.after_each()
	farmer.free()
	

func test_energy_connected_to_minute_ticks():
	assert_connected(game_o_clock, farmer.energy, "minute_tick")


func test_energy_depletes():
	var energy = farmer.energy._value
	forward_time(game_o_clock.game_minute_real_msec * 10)
	assert_gt(farmer.energy._value, energy)
