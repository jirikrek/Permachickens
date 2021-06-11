extends BaseNeed
class_name Energy

# How many times a day an agent would reach the max need level.
export var tiredness = 1.0
var minute_tiredness = 1.0 / (Globals.game_o_clock.MINUTES_IN_DAY / tiredness)


func on_game_minute_tick():
	set_need(_value + minute_tiredness)


func _to_string():
	return "Energy: %.2f" % _value
