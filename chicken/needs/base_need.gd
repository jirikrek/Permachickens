extends Reference 
class_name BaseNeed

signal died


# How big the need is. Death comes with _value >= 1.0
var _value := 0.0 setget set_need


func _die():
	emit_signal("died")

func set_need(new_need_value):
	_value = new_need_value
	if _value >= 1:
		_die()
