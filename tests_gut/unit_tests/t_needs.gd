extends GUTTest

var water: Water
var food: Food
var life_length: LifeLength
var energy: Energy
var needs


func before_each():
	water = Water.new()
	food = Food.new()
	energy = Energy.new()
	life_length = LifeLength.new(100)
	needs = [water, food, life_length, energy]


func test_need_growth(need=use_parameters(needs)):
	need.on_game_minute_tick()
	assert_gt(need._value, need.min_value, need.to_string())
	

func test_setter(need = use_parameters(needs)):
	watch_signals(need)
	need._value = need.max_value
	assert_signal_emitted(need, "urgency_max", need.to_string())


func test_need_growth_until_dead(need = use_parameters(needs)):
	watch_signals(need)
	while need._value < need.max_value:
		need.on_game_minute_tick()
	assert_signal_emit_count(need, "urgency_max", 1, need.to_string())


func test_need_does_not_grow_over_one(need: BaseNeed = use_parameters(needs)):
	while need._value < need.max_value:
		need.on_game_minute_tick()
	
	# first check we ended up at max_value
	assert_eq(need._value, need.max_value)
	# now proceed in time even more
	need.on_game_minute_tick()
	# and check it again
	assert_eq(need._value, need.max_value)
