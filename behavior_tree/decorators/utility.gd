extends BTDecorator


# Provides a exported vara get_utility function Succeeds always.

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result = bt_child.tick(agent, blackboard)
	
	if result is GDScriptFunctionState:
		result = yield(result, "completed")
	
	if bt_child.succeeded():
		return fail()
	return succeed()

