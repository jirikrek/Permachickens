extends _BaseBehaviorTest


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
	
