extends WAT.Test

var water: Water
var food: Food

# TODO: Rewrite to be generic test for all needs.

func pre():
	water = Water.new()
	food = Food.new()


func init_params():
	parameters([["need"], [water], [food]])


func test_need_growth():
	parameters([["need"], [water], [food]])
	p.need.on_game_minute_tick()
	asserts.is_greater_than(p.need._value, 0, p.need.to_string())
	

func test_setter():
	init_params()
	watch(p.need, "died")
	p.need._value = 1
	asserts.signal_was_emitted(p.need, "died", p.need.to_string())


func test_need_growth_until_dead():
	init_params()
	watch(p.need, "died")
	while p.need._value < 1:
		asserts.signal_was_not_emitted(p.need, "died")
		p.need.on_game_minute_tick()
	asserts.signal_was_emitted(p.need, "died", p.need.to_string())
	
