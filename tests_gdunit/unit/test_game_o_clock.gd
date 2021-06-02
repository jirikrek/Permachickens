extends GdUnitTestSuite

var original_clock
var current_time := 0
var time_mock
var game_o_clock_spy

func get_ticks_msec() -> int:
	return current_time


func before_test():
	print("WTF?? =O")


func after_test():
	pass


func test_minute_signal():
	time_mock = mock("res://common/scripts/real_world_time.gd")
	#game_o_clock_spy = mock("res://auto_loads/game_o_clock.gd", CALL_REAL_FUNC)
	#for prop in game_o_clock_spy.get_property_list():
	#	print(str(prop))
	#game_o_clock_spy.real_time_provider = time_mock
	#assert_object(game_o_clock_spy.real_time_provider).is_not_equal(GameOClock.real_time_provider)

	# this is not very good test, it's unclear, whether the signal should have been emited
	# or not
	# One good solution would be to allow to run/stop the GameOClock
	print_debug("call process")
	game_o_clock_spy._process(10.0)
	print_debug("check for emitted signal")
	verify(game_o_clock_spy).emit_signal("minute_tick")

#
#func test_two_minutes():
#	# initialize
#	time_provider.method("get_ticks_msec").stub(1000)
#	# NOTE: I wanted to rewrite this test to use stub instead of funcRef to provide the mocked
#	# return value, but none of the methods is usefull and I am abandoning WAT.
#	# (every time stub() is called new value is being added to the array - not very nice with
#	# unpredictable results. WAT v5.0.1)
#	print("current_time=" + str(GameOClock.real_time_provider.get_ticks_msec()))
#	GameOClock._process(0)
#	watch(GameOClock, "minute_tick")
#
#	# first minute
#	current_time += GameOClock.game_minute_real_msec
#	print("current_time=" + str(GameOClock.real_time_provider.get_ticks_msec()))
#	GameOClock._process(0)
#
#	# second minute
#	current_time += GameOClock.game_minute_real_msec
#	print("current_time=" + str(GameOClock.real_time_provider.get_ticks_msec()))
#	GameOClock._process(0)
#
#	asserts.signal_was_emitted_x_times(GameOClock, "minute_tick", 2)
#
