extends BaseBehaviorTest


func _create_behavior():
	return Cohesion.new()
	
	
func test_cohesion_pair():
	set_nearby_hens([Vector2(3, 3)])
	var vector := get_result()
	assert_eq(vector, Vector2(2,2))


func test_cohesion_triplet1():
	set_nearby_hens([Vector2(4, 4), Vector2(5, 5)])
	var vector = get_result()
	assert_eq(vector, Vector2(3.5, 3.5))
	

func test_cohesion_triplet2():
	set_nearby_hens([Vector2(0, 2), Vector2(2, 2)])
	var vector = get_result()
	assert_eq(vector, Vector2(0, 1))
	
