extends BaseBehaviorTest


func _create_behavior():
	return StayInRadius.new()

# No real use for this class yet, so nothing to test really. 
func test_stay_in_radius():
	assert_true(true)
	pass
