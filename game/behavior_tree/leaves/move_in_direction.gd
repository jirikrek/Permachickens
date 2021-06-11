extends BTLeaf
class_name MoveInDirection

export var dir: String

var delta

func _pre_tick(agent, blackboard):
	delta = blackboard.get_data("delta")

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var vector: Vector2 = blackboard.get_data(dir)
	if vector != Vector2.ZERO:
		agent.move_and_slide(vector.normalized())
		print_debug(vector)
	return succeed()
