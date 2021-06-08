extends BaseOClockTest

var chicken_scene = load("res://chicken/chicken.tscn")
var chicken: Chicken


func before_each():
	.before_each()
	Globals.random = double(RandomNumberGenerator).new()


func test_life_span_does_not_go_below_zero():
	stub(Globals.random, "randfn").to_return(Chicken.MIN_AGE - 0.5)
	chicken = autofree(chicken_scene.instance())
	assert_true(chicken.life_span >= Chicken.MIN_AGE * GameOClock.MINUTES_IN_YEAR)


func test_life_span_is_not_bigger_then_fifteen():
	stub(Globals.random, "randfn").to_return(Chicken.MAX_AGE + .1)
	chicken = autofree(chicken_scene.instance())
	assert_true(chicken.life_span == Chicken.MAX_AGE * GameOClock.MINUTES_IN_YEAR)

