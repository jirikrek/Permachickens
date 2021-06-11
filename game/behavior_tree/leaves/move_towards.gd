extends BTLeaf
class_name MoveTowards

export var target_key: String
export var speed: int = 3

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var target: Node2D = blackboard.get_data(target_key)
	var vector = target.global_position - agent.global_position
	agent.move_and_slide(vector.normalized() * speed)
	return succeed()
