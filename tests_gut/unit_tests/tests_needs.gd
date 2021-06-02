extends GUTTest

var water: Water
var food: Food
var needs


func before_each():
	water = Water.new()
	food = Food.new()
	needs = [water, food]


func test_need_growth(need=use_parameters(needs)):
	need.on_game_minute_tick()
	assert_gt(need._value, 0.0, need.to_string())
	

func test_setter(need = use_parameters(needs)):
	watch_signals(need)
	need._value = 1
	assert_signal_emitted(need, "died", need.to_string())


func test_need_growth_until_dead(need = use_parameters(needs)):
	watch_signals(need)
	while need._value < 1:
		need.on_game_minute_tick()
	assert_signal_emit_count(need, "died", 1, need.to_string())
	

