extends BTDecorator
class_name BTFoodUtility
export var hen_path: NodePath

func get_utility(agent:Hen):
	return agent.food._value

