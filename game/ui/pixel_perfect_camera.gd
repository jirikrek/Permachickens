extends Camera2D

var follow
export var DESIRED_RESOLUTION = Vector2(320, 180)
var vp
var scaling_factor = 1

func _ready():
	follow = $"../Farmer"  # FIXME: get rid of hardcoded reference
	vp = get_viewport()
	#vp.connect("size_changed", self, "on_vp_size_change")
	#on_vp_size_change()


# unused for now, may be removed in the future
func on_vp_size_change():
	var scale_vector = vp.size / DESIRED_RESOLUTION
	var new_scaling_factor = max(floor(min(scale_vector[0], scale_vector[1])), 1)
	if new_scaling_factor != scaling_factor:
		scaling_factor = new_scaling_factor
		zoom = Vector2(1 / scaling_factor, 1 / scaling_factor)
		print_debug("zoom set to: %s" % zoom)


# Make sure that camera position is always rounded to pixel perfect value.
func _process(delta):
	offset.x = stepify(follow.position.x, 0.2) # FIXME: replace magic constant 0.2 with computed value
	offset.y = stepify(follow.position.y, 0.2)
