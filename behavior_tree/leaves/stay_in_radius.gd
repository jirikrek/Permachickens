extends BTLeaf
export var center : Vector2
export var radius = 15;
export var result : Vector2
#
#    public override TaskStatus OnUpdate() {
#        Vector2 centerOffset = center.Value - (Vector2) transform.position;
#        float t = centerOffset.magnitude / radius;
#        if (t < 0.9f) {
#            result.Value = Vector2.zero;
#        }
#        else {
#            result.Value = centerOffset * t * t;
#        }
#
#        return TaskStatus.Success;
#    }


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var centerOffset = center - agent.position
	var t = centerOffset.magnitude / radius
	if t < 0.9:
		#blackboard.set_data()
		result = Vector2.ZERO
	else:
		result = centerOffset * t * t
	return succeed()
