extends BaseNeed
class_name Water

# How many times a day a hen would die from dehydration.
export var thirstiness = 0.5
var minute_thirst = 1.0 / (GameOClock.MINUTES_IN_DAY / thirstiness)

const DRINKING_SPEED = 0.01


func drink(resource):
	set_need(_value - DRINKING_SPEED)
	resource.subtract(DRINKING_SPEED)


func on_game_minute_tick():
	set_need(_value + minute_thirst)


func _to_string():
	return "Water: %.2f" % _value
