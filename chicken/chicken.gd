extends KinematicBody2D
class_name Chicken
var water := Water.new()
var food := Food.new()
var life_length: LifeLength

var needs
var alive = true
var age setget set_age, get_age		# current life length in game minutes 
var life_span setget set_life_span	# total length of life in game minutes
const EATING_SPEED = 0.003
const DRINKING_SPEED = 0.004
const MAX_AGE = 15.0
const MIN_AGE = 0.0

func _init():
	life_span = generate_life_span_years() * GameOClock.MINUTES_IN_YEAR
	life_length = LifeLength.new(life_span)
	needs = [water, food, life_length]


func _ready():
	_connect_needs_listeners()


func _connect_needs_listeners():
	for need in needs:
		Globals.game_o_clock.connect("minute_tick", need, "on_game_minute_tick")
		need.connect("died", self, "die")


func _disconnect_needs_listeners():
	for need in needs:
		Globals.game_o_clock.disconnect("minute_tick", need, "on_game_minute_tick")
		need.disconnect("died", self, "die")


func drink(resource):
	satisfy(water, resource, DRINKING_SPEED)


func eat(resource):
	satisfy(food, resource, EATING_SPEED)


func satisfy(need, resource, amount):
	if alive:
		need.satisfy(resource, amount)


func die():
	alive = false
	$AnimatedSprite.rotation_degrees = 90
	set_process(false)
	$BehaviorTree.abort()
	_disconnect_needs_listeners()


func set_life_span(value):
	push_error("Hen life span can't be changed from outside.")


func set_age(value):
	if life_length._value == 0:
		life_length._value = value
	else:
		push_error("Cannot change hen age.")


# return age in game minutes
func get_age():
	return life_length._value


func describe():
	var desc = "Chicken: " + name + "\n"
	for need in needs:
		desc += str(need)
		desc += "\n"
		
	return desc

# Generates life span with normal distribution in game years.
static func generate_life_span_years():
	var mean = 4
	var standard_deviation = 1.5
	var new_life_span = Globals.random.randfn(mean, standard_deviation)
	return min(MAX_AGE, max(MIN_AGE, new_life_span))

