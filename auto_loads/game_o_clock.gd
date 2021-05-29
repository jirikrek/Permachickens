tool
extends Node

signal minute_tick()

# Number of minutes in a normal day (it's 60 * 24)
const MINUTES_IN_DAY = 1440
export var game_day_real_seconds = 60.0 # seconds
var game_minute_real_milis = game_day_real_seconds / MINUTES_IN_DAY * 1000
var _next_minute_ticks = 0

func _ready():
	_next_minute_ticks = OS.get_ticks_msec() + game_minute_real_milis
	print_debug("One game minute in real miliseconds: %s" % game_minute_real_milis)

func _process(_delta):
	var currentTime = OS.get_ticks_msec()
	if currentTime >= _next_minute_ticks:
		emit_signal("minute_tick")
		_next_minute_ticks += game_minute_real_milis
	
