extends BTLeaf
class_name SaveClickDir

export var result: String


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	if Input.is_action_pressed("ui_mouse_click"):
		var position = get_viewport().get_mouse_position() 
		print_debug(position)
		blackboard.set_data(result, position)
	else:
		blackboard.set_data(result, Vector2.ZERO)
	return succeed()
