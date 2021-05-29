extends BaseNeed
class_name Food

# How many times a day a hen would die from food deprivation.
export var hungriness = 0.25
var minute_hunger = 1.0 / (GameOClock.MINUTES_IN_DAY / hungriness)

const EATING_SPEED = 0.01

# How much hungry the hen is. Death comes with _value >= 1.0
var _value := 0.0


func _init():
	GameOClock.connect("minute_tick", self, "on_game_minute_tick")

func eat(resource):
	_value -= EATING_SPEED
	resource.subtract(EATING_SPEED)


func on_game_minute_tick():
	_value += minute_hunger
