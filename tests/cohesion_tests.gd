extends WATTest

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
	pass


func get_result() -> Vector2:
	asserts.is_true(cohesion.tick(agent, blackboard))
	asserts.is_equal(cohesion.state, BTNode.BTNodeState.SUCCESS)
	var vector = blackboard.get_data("result")
	asserts.is_not_null(vector)
	return vector


func test_cohesion_pair():
	blackboard.set_data("nearbyHens", nearbyHens)
	var vector := get_result()
	asserts.is_equal(vector, Vector2(2,2))


func test_cohesion_triplet1():
	blackboard.set_data("nearbyHens", [ create_hen(Vector2(4, 4)), create_hen(Vector2(5, 5))])
	var vector = get_result()
	asserts.is_equal(vector, Vector2(3.5, 3.5))
	

func test_cohesion_triplet2():
	blackboard.set_data("nearbyHens", [ create_hen(Vector2(0, 2)), create_hen(Vector2(2, 2))])
	var vector = get_result()
	asserts.is_equal(vector, Vector2(0, 1))
	
