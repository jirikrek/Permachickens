class_name UtilitySelector, "res://addons/behavior_tree/icons/btsequence.svg" 
extends BTComposite

# Ticks a child with highest utility of them all.
# Successful if selected child are successful.
# Fails if ANY of the children fails.
var utilised_children := []

class UtilitySorter:
	static func sort_descending(a, b):
		if a[0] > b[0]:
			return true
		return false

func utilise_children(agent:Chicken):
	utilised_children.clear()
	for child in children:
		if child.has_method("get_utility"):
			utilised_children.append([child.get_utility(agent), child])
		else:
			utilised_children.append([0, child])
	
	utilised_children.sort_custom(UtilitySorter, "sort_descending")
			

func _pre_tick(agent: Node, blackboard: Blackboard) -> void:
	utilise_children(agent)


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result
	
	for c in utilised_children:
		bt_child = c[1]
		
		result = bt_child.tick(agent, blackboard)
		
		if result is GDScriptFunctionState:
			result = yield(result, "completed")
		
		if bt_child.succeeded():
			return succeed()
	
	return fail()
