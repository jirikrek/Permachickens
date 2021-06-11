extends Reference 
class_name BaseNeed

signal urgency_max

var max_value = 1.0
var min_value = 0.0

# How big the need is. Death comes with _value == 1.0
var _value := 0.0 setget set_need

	
func _die():
	emit_signal("urgency_max")

func set_need(new_need_value):
	_value = new_need_value
	_value = min(max_value, max(min_value, _value))
	if _value >= max_value:
		_die()
		

func is_full():
	return _value < (min_value + 0.001)


func satisfy(resource, amount):
	set_need(_value - amount)
	#resource.subtract(DRINKING_SPEED)
