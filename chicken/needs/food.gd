extends BaseNeed
class_name Food

# How many times a day a hen would die from food deprivation.
export var hungriness = 0.25
var minute_hunger = 1.0 / (GameOClock.MINUTES_IN_DAY / hungriness)

const EATING_SPEED = 0.01


func eat(resource):
	set_need(_value - EATING_SPEED)
	resource.subtract(EATING_SPEED)


func on_game_minute_tick():
	set_need(_value + minute_hunger)


func _to_string():
	return "Food: %.2f" % _value
