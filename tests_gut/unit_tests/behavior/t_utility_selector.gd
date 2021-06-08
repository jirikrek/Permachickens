extends BaseBehaviorTest

var TEST_SCRIPT = load("res://tests_gut/unit_tests/behavior/t_utility_selector.gd")
var und

class UtilityNode:
	extends BTNode
	
	var utility := 0.0
	var will_succeed = true
	
	func _tick(agent: Node, blackboard: Blackboard) -> bool:
		return succeed() if will_succeed else fail()
		
	func get_utility(agent):
		return utility


func _create_behavior():
	return UtilitySelector.new()


func before_each():
	.before_each()
	und = partial_double(TEST_SCRIPT, "UtilityNode")


func test_utility_sorting():
	# Dva potomci, jeden vrátí 0.3 a druhý 0.5 utility, oba z _tick vrací succeed()
	# Zkontrolovat, že _tickne jen ten druhý 
	var child1 = und.new()
	var child2 = und.new()
	child1.utility = 0.3
	child2.utility = 0.5
	
	behavior.add_child(child1)
	behavior.add_child(child2)
	
	behavior._ready()
	behavior._pre_tick(null, null)
	behavior._tick(null, null)
	
	assert_called(child2, "_tick")
	assert_not_called(child1, "_tick")


func test_utility_sorting_with_failure():
	var child1 = und.new()
	var child2 = und.new()
	child1.utility = 0.3
	child2.utility = 0.5

	child2.will_succeed = false

	behavior.add_child(child1)
	behavior.add_child(child2)

	behavior._ready()
	behavior._pre_tick(null, null)
	behavior._tick(null, null)

	assert_called(child2, "_tick")
	assert_called(child1, "_tick")

func test_get_utility_called_once():
	var child1 = und.new()
	var child2 = und.new()
	child1.utility = 0.3
	child2.utility = 0.5
	
	child2.will_succeed = false
	
	behavior.add_child(child1)
	behavior.add_child(child2)
	
	behavior._ready()
	behavior._pre_tick(null, null)
	behavior._tick(null, null)
	
	assert_call_count(child1, "get_utility", 1)
	assert_call_count(child2, "get_utility", 1)
