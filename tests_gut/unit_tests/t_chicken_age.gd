extends BaseOClockTest

var hen_scene = load("res://game/hen/hen.tscn")
var hen: Hen


func before_each():
	.before_each()
	Globals.random = double(RandomNumberGenerator).new()


func test_life_span_does_not_go_below_zero():
	stub(Globals.random, "randfn").to_return(Hen.MIN_AGE - 0.5)
	hen = autofree(hen_scene.instance())
	assert_true(hen.life_span >= Hen.MIN_AGE * GameOClock.MINUTES_IN_YEAR)


func test_life_span_is_not_bigger_then_fifteen():
	stub(Globals.random, "randfn").to_return(Hen.MAX_AGE + .1)
	hen = autofree(hen_scene.instance())
	assert_true(hen.life_span == Hen.MAX_AGE * GameOClock.MINUTES_IN_YEAR)

