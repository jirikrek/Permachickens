extends BaseOClockTest

var chicken_scene = load("res://chicken/chicken.tscn")
var chicken: Chicken


func before_each():
	.before_each()
	chicken = chicken_scene.instance()
	add_child(chicken)


func after_each():
	chicken.free()
	.after_each()


func test_all_needs_listen_for_minute_ticks():
	for need in chicken.needs:
		assert_connected(Globals.game_o_clock, need, "minute_tick")


func test_chicken_listens_to_died_signals_of_every_need():
	for need in chicken.needs:
		assert_connected(need, chicken, "died")
	

func test_chicken_disconnects_all_signals_upon_death():
	chicken.die()
	for need in chicken.needs:
		assert_eq(need.get_incoming_connections().size(), 0)
	assert_eq(chicken.get_incoming_connections().size(), 0)


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


