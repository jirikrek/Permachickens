extends BaseOClockTest


func test_test_setup():
	stub(real_world_time, "get_ticks_msec").to_return(__current_time)
	assert_eq(real_world_time.get_ticks_msec(), __current_time)
	

func test_minute_signal():
	watch_signals(game_o_clock)
	
	game_o_clock.recalculate()
	assert_signal_not_emitted(game_o_clock, "minute_tick")
	
	forward_time(game_o_clock.game_minute_real_msec)
	game_o_clock.recalculate()
	assert_signal_emitted(game_o_clock, "minute_tick")
	

func test_two_minutes():
	game_o_clock.recalculate()
	watch_signals(game_o_clock)

	# first minute
	forward_time(game_o_clock.game_minute_real_msec)
	game_o_clock.recalculate()

	# second minute
	forward_time(game_o_clock.game_minute_real_msec)
	game_o_clock.recalculate()

	assert_signal_emit_count(game_o_clock, "minute_tick", 2)


func test_two_minutes_in_one_run():
	game_o_clock.recalculate()
	watch_signals(game_o_clock)
	
	forward_time(game_o_clock.game_minute_real_msec * 2)
	game_o_clock.recalculate()
	
	assert_signal_emit_count(game_o_clock, "minute_tick", 2)
