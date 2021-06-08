extends GUTTest
class_name BaseBehaviorTest

var blackboard: Blackboard
var agent: Node2D
var behavior: BTNode
var nearby_hens := [] setget set_nearby_hens

# Override in each test suite and return BTNode to perform tests upon.
func _create_behavior():
	pass

func set_nearby_hens(positions: Array):
	nearby_hens.clear()
	for vector in positions:
		nearby_hens.append(create_hen(vector))
	blackboard.set_data("nearbyHens", nearby_hens)


func create_hen(position):
	var hen := Node2D.new()
	hen.position = position
	return hen


func before_each():
	blackboard = Blackboard.new()
	agent = create_hen(Vector2(1, 1))
	behavior = _create_behavior()


func after_each():
	blackboard.free()
	agent.free()
	behavior.free()
	for hen in nearby_hens:
		hen.free()
	nearby_hens.clear()


func get_result() -> Vector2:
	assert_true(behavior.tick(agent, blackboard))
	assert_eq(behavior.state, BTNode.BTNodeState.SUCCESS)
	var vector = blackboard.get_data("result")
	assert_not_null(vector)
	return vector

