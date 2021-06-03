extends BTLeaf
class_name Cohesion

export var center : Vector2
export var radius = 15;
export var result : Vector2
#    public SharedTransformList nearbyFowls;
#    [RequiredField]
#    public SharedVector2 result;
#
#    public override void OnStart() {
#        base.OnStart();
#        result.Value = Vector2.zero;
#    }
#
#    public override TaskStatus OnUpdate() {
#        //add all points together and average
#
#        foreach (Transform item in nearbyFowls.Value) {
#            result.Value += (Vector2) item.position;
#        }
#
#        result.Value /= nearbyFowls.Value.Count;
#
#        //create offset from agent position
#        result.Value -= (Vector2) transform.position;
#        return TaskStatus.Success;
#    }


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var nearby_hens = blackboard.get_data("nearbyHens")
	var result = Vector2.ZERO
	
	for hen in nearby_hens:
		result += hen.position
	
	result /= nearby_hens.size()

	# create offset from agent position
	result -= agent.position
	blackboard.set_data("result", result)
	return succeed()
