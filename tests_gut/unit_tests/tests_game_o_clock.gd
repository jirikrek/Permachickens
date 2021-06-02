extends GUTTest


var doubled_time_provider
var __current_time := 0 setget set_time
var game_o_clock: GameOClock
var real_world_time


func set_time(msec):
	__current_time = msec
	stub(real_world_time, "get_ticks_msec").to_return(__current_time)
	gut.p("current_time=%d" % __current_time)

func forward_time(msec):
	set_time(__current_time + msec)
	

func before_each():
	real_world_time = double(RealWorldTime).new()
	game_o_clock = partial_double("res://auto_loads/game_o_clock.gd").new()
	game_o_clock._real_time_provider = real_world_time
	set_time(100)

	
func after_each():
	pass
	

func test_test_setup():
	stub(real_world_time, "get_ticks_msec").to_return(__current_time)
	assert_eq(real_world_time.get_ticks_msec(), __current_time)
	

func test_minute_signal():
	watch_signals(game_o_clock)
	
	# start the clock
	game_o_clock.run()
	
	game_o_clock.recalculate()
	assert_signal_not_emitted(game_o_clock, "minute_tick")
	
	forward_time(game_o_clock.game_minute_real_msec)
	game_o_clock.recalculate()
	assert_signal_emitted(game_o_clock, "minute_tick")
	

func test_two_minutes():
	# start the clock
	game_o_clock.run()
	
	game_o_clock.recalculate()
	watch_signals(game_o_clock)

	# first minute
	forward_time(game_o_clock.game_minute_real_msec)
	game_o_clock.recalculate()

	# second minute
	forward_time(game_o_clock.game_minute_real_msec)
	game_o_clock.recalculate()

	assert_signal_emit_count(game_o_clock, "minute_tick", 2)

