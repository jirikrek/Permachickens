extends BaseOClockTest

var hen_scene = load("res://game/hen/hen.tscn")
var hen: Hen


func before_each():
	.before_each()
	hen = hen_scene.instance()
	add_child(hen)


func after_each():
	hen.free()
	.after_each()


func test_hen_has_life_span():
	assert_true(hen.life_span >= 0)


func test_hen_life_length_max_is_life_span():
	assert_true(hen.life_length.max_value == hen.life_span)
	

func test_all_needs_listen_for_minute_ticks():
	for need in hen.needs:
		assert_connected(Globals.game_o_clock, need, "minute_tick")


func test_hen_listens_to_died_signals_of_every_need():
	for need in hen.needs:
		assert_connected(need, hen, "urgency_max")
	

func test_hen_disconnects_all_signals_upon_death():
	hen.die()
	for need in hen.needs:
		assert_eq(need.get_incoming_connections().size(), 0)
	assert_eq(hen.get_incoming_connections().size(), 0)


func test_do_not_update_needs_when_dead():
	var water = hen.water._value
	var food = hen.food._value
	
	hen.die()

	# forward ten minutes
	forward_time(game_o_clock.game_minute_real_msec * 10)
	game_o_clock.recalculate()
	
	assert_eq(water, hen.water._value)
	assert_eq(food, hen.food._value)


func test_hen_can_not_eat_when_dead(need=use_parameters(hen.needs)):
	hen.die()
	var need_before_death = 0.5
	need._value = need_before_death
	# FIXME: provide Resource once implemented
	hen.satisfy(need, null, 0.1)
	
	assert_eq(need._value, need_before_death)


