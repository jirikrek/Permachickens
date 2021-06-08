extends GUTTest
class_name BaseOClockTest

var original_time_provider
var real_world_time
var __current_time := 0 setget set_time
var game_o_clock

func set_time(msec):
	__current_time = msec
	stub(real_world_time, "get_ticks_msec").to_return(__current_time)
	gut.p("current_time=%d" % __current_time)


func forward_time(msec):
	set_time(__current_time + msec)
	

func before_each():
	game_o_clock = Globals.game_o_clock
	original_time_provider = game_o_clock._real_time_provider
	
	real_world_time = double(RealWorldTime).new()
	game_o_clock._real_time_provider = real_world_time
	set_time(100)
	
	# start the clock
	game_o_clock.run()


func after_each():
	game_o_clock.stop()
	game_o_clock._real_time_provider = original_time_provider
