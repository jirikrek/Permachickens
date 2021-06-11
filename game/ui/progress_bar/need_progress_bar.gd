tool
extends TextureProgress

var need: BaseNeed

# TODO: in the future it may be necessary to watch for min/max_value changes in Needs!

func _ready():
	if Engine.editor_hint:
		max_value = 100
		value = 40
	else:
		max_value = need.max_value
		min_value = need.min_value

	step = (max_value - min_value) / 100.0

func _process(delta):
	if not Engine.editor_hint:
		value = max_value - need._value + min_value
