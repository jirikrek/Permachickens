extends BTDecorator
class_name BTNeedUtility
export var hen_path: NodePath

func get_utility(agent:Hen):
	return agent.water._value

