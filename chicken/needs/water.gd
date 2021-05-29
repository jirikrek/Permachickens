extends BaseNeed
class_name Water

# How many times a day a hen would die from dehydration.
export var thirstiness = 0.5
var minute_thirst = 1.0 / (GameOClock.MINUTES_IN_DAY / thirstiness)

const DRINKING_SPEED = 0.01

# How much thirsty hen is. Death comes with _value >= 1.0
var _value := 0.0


func _init():
	GameOClock.connect("minute_tick", self, "on_game_minute_tick")


func drink(resource):
	_value -= DRINKING_SPEED
	resource.subtract(DRINKING_SPEED)


func on_game_minute_tick():
	_value += minute_thirst
