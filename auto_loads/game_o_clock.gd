tool
extends Node

signal minute_tick()

# Number of minutes in a normal day (it's 60 * 24)
const MINUTES_IN_DAY = 1440
export var game_day_real_seconds = 5 # seconds
var game_minute_real_msec: int = floor(float(game_day_real_seconds) / MINUTES_IN_DAY * 1000)
var _last_minute_ticks = 0 setget set_last_minute_ticks 
var _real_time_provider


func set_last_minute_ticks(value):
	_last_minute_ticks = value


func _ready():
	set_process(false)

# Start the clock.
func run():
	if _real_time_provider == null:
		_real_time_provider = RealWorldTime.new()
	print("One game minute in real miliseconds: %s" % game_minute_real_msec)
	set_last_minute_ticks(_real_time_provider.get_ticks_msec())
	set_process(true)


# Checks current realtime and updates the game time accordingly.
# Emits time signals when necessary.
func recalculate():
	var current_time = _real_time_provider.get_ticks_msec()
	var elapsed_minutes = (current_time - _last_minute_ticks) / game_minute_real_msec
	for minute in range(elapsed_minutes):
		emit_signal("minute_tick")
	
	set_last_minute_ticks(_last_minute_ticks + elapsed_minutes * game_minute_real_msec)


func stop():
	set_process(false)


func _process(_delta):
	recalculate()


