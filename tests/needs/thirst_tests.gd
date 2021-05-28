extends WAT.Test

var thirst: Thirst

func pre():
	thirst = Thirst.new()

func test_thirst_growth():
	print(GameTime.get_day_delta(1))
	thirst.update(1)
	asserts.is_greater_than(thirst._value, 0)
	
