extends BaseNeed
class_name LifeLength

# Stores life length in game minutes into _value.

func _init(life_span):
	max_value = life_span


func on_game_minute_tick():
	set_need(_value + 1)


func years():
	return _value / float(GameOClock.MINUTES_IN_YEAR)
	
	
func _to_string():
	return "Age: %dmin(%.2fyrs) / %dmin" % [_value, years(), max_value ]
