extends BTLeaf
class_name Drink

export var resource_key:String


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	# TODO: maybe implement this through Area2Ds?
	var resource:Node2D = blackboard.get_data(resource_key)
	var distance = (agent.position - resource.position).length()
	if distance > 10:
		return fail()
	else:
		while not agent.water.is_full():
			agent.drink(resource)
			yield(get_tree(), "idle_frame")
		return succeed()
