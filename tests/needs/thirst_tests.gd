extends WAT.Test

var water: Water

func pre():
	water = Water.new()

func test_thirst_growth():
	print(GameOClock.get_day_delta(1))
	water.update(1)
	asserts.is_greater_than(water._value, 0)
	
