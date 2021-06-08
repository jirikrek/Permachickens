extends BTDecorator
class_name BTNeedUtility
export var chicken_path: NodePath

func get_utility(agent:Chicken):
	return agent.water._value

