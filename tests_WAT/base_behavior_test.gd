extends WATTest
class_name _BaseBehaviorTest

var blackboard: Blackboard
var agent: Node2D
var cohesion: Cohesion
var nearbyHens


func create_hen(position):
	var hen := Node2D.new()
	hen.position = position
	return hen


func start():
	nearbyHens = [ create_hen(Vector2(3, 3)) ]


func pre():
	blackboard = Blackboard.new()
	agent = create_hen(Vector2(1, 1))
	cohesion = Cohesion.new()


func post():
	blackboard.free()
	agent.free()
	cohesion.free()


func get_result() -> Vector2:
	asserts.is_true(cohesion.tick(agent, blackboard))
	asserts.is_equal(cohesion.state, BTNode.BTNodeState.SUCCESS)
	var vector = blackboard.get_data("result")
	asserts.is_not_null(vector)
	return vector

func test_pass():
	describe("This is just base class")
	asserts.is_true(true)
