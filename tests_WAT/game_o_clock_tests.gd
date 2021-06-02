extends WATTest

var original_time_provider
var current_time := 0
var time_provider

func get_ticks_msec() -> int:
	return current_time


func pre():
	original_time_provider = GameOClock.real_time_provider
	time_provider = direct.script("res://common/scripts/real_world_time.gd")
	GameOClock.real_time_provider = time_provider.double()


func post():
	GameOClock.real_time_provider = original_time_provider
	

func test_minute_signal():
	watch(GameOClock, "minute_tick")
	GameOClock._process(10.0)
	asserts.signal_was_emitted(GameOClock, "minute_tick")

func test_two_minutes():
	# initialize
	time_provider.method("get_ticks_msec").stub(1000)
	# NOTE: I wanted to rewrite this test to use stub instead of funcRef to provide the mocked
	# return value, but none of the methods is usefull and I am abandoning WAT.
	# (every time stub() is called new value is being added to the array - not very nice with
	# unpredictable results. WAT v5.0.1)
	print("current_time=" + str(GameOClock.real_time_provider.get_ticks_msec()))
	GameOClock._process(0)
	watch(GameOClock, "minute_tick")
	
	# first minute
	current_time += GameOClock.game_minute_real_msec
	print("current_time=" + str(GameOClock.real_time_provider.get_ticks_msec()))
	GameOClock._process(0)
	
	# second minute
	current_time += GameOClock.game_minute_real_msec
	print("current_time=" + str(GameOClock.real_time_provider.get_ticks_msec()))
	GameOClock._process(0)
	
	asserts.signal_was_emitted_x_times(GameOClock, "minute_tick", 2)
	
