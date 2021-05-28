extends BTLeaf
class_name FindNodeFromGroup

export var group: String
export var result: String


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var nodes = get_tree().get_nodes_in_group(group)
	
	if nodes.size() <= 0:
		return fail()
	
	blackboard.set_data(result, nodes[0])
	return succeed()
