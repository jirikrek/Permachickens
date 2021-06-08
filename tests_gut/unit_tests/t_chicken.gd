extends BaseOClockTest

var chicken_scene = load("res://chicken/chicken.tscn")
var chicken: Chicken


func before_each():
	.before_each()
	chicken = chicken_scene.instance()
	add_child(chicken)


func after_each():
	.after_each()
	chicken.free()


# TODO: It seems like the assert_connected has bug. Implement my own version.
func assert_signal_connected():
	pass

func test_all_needs_listen_for_minute_ticks(need=use_parameters(chicken.needs)):
	assert_connected(Globals.game_o_clock, need, "minute_tick")


func test_chicken_listens_to_death_signal(need=use_parameters(chicken.needs)):
	assert_connected(need, chicken, "died")
	

func test_do_not_update_needs_when_dead():
	var water = chicken.water._value
	var food = chicken.food._value
	
	chicken.die()

	# forward ten minutes
	forward_time(game_o_clock.game_minute_real_msec * 10)
	game_o_clock.recalculate()
	
	assert_eq(water, chicken.water._value)
	assert_eq(food, chicken.food._value)


func test_chicken_can_not_eat_when_dead(need=use_parameters(chicken.needs)):
	chicken.die()
	var need_before_death = 0.5
	need._value = need_before_death
	# FIXME: provide Resource once implemented
	chicken.satisfy(need, null, 0.1)
	
	assert_eq(need._value, need_before_death)


