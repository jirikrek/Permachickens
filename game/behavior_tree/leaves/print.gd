extends BTLeaf

export var message = "Hello World!"

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	print(message)
	return succeed()
