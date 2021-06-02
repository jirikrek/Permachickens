tool
extends Node

signal minute_tick()

# Number of minutes in a normal day (it's 60 * 24)
const MINUTES_IN_DAY = 1440
export var game_day_real_seconds = 60 # seconds
var game_minute_real_msec: int = floor(float(game_day_real_seconds) / MINUTES_IN_DAY * 1000)
var _next_minute_ticks = 0 setget set_next_minute_ticks 
var _real_time_provider


func set_next_minute_ticks(value):
	_next_minute_ticks = value
	print("next_minute_ticks=%.4f" % _next_minute_ticks)

func _ready():
	set_process(false)

# Start the clock.
func run():
	if _real_time_provider == null:
		_real_time_provider = RealWorldTime.new()
	print("One game minute in real miliseconds: %s" % game_minute_real_msec)
	set_next_minute_ticks(_real_time_provider.get_ticks_msec() + game_minute_real_msec)
	set_process(true)


# Checks current realtime and updates the game time accordingly.
# Emits time signals when necessary.
func recalculate():
	var current_time = _real_time_provider.get_ticks_msec()
	print("GameOClock.current_real_time=%d" % current_time)
	if current_time >= _next_minute_ticks:
		emit_signal("minute_tick")
		set_next_minute_ticks(_next_minute_ticks + game_minute_real_msec)


func stop():
	set_process(false)


func _process(_delta):
	recalculate()


