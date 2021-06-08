extends BTDecorator
class_name BTFoodUtility
export var chicken_path: NodePath

func get_utility(agent:Chicken):
	return agent.food._value

