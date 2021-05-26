# Source: https://alvarber.gitlab.io/pixel-perfection-in-godot.html
# Scales viewport at integer scale, based on viewport size.
# TODO: I will probably want to set fixed scale rate regardless the viewport size?
# TODO: How to handle higher DPI screens then?

extends Camera2D

export var DESIRED_RESOLUTION = Vector2(320, 180)
var vp
var scaling_factor = 1

func _ready():
	vp = get_viewport()
	vp.connect("size_changed", self, "on_vp_size_change")
	on_vp_size_change()

func on_vp_size_change():
	var scale_vector = vp.size / DESIRED_RESOLUTION
	var new_scaling_factor = max(floor(min(scale_vector[0], scale_vector[1])), 1)
	if new_scaling_factor != scaling_factor:
		scaling_factor = new_scaling_factor
		zoom = Vector2(1 / scaling_factor, 1 / scaling_factor)
		print_debug("zoom set to: %s" % zoom)
