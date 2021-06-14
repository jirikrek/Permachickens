extends GUTTest


var progress_scene
var progress: TextureProgress
var e: Energy

func before_all():
	.before_all()
	progress_scene = load("res://game/ui/progress_bar/progress_bar.tscn")


func before_each():
	.before_each()
	progress = progress_scene.instance()
	e = Energy.new()
	e.max_value = 5.0
	e.min_value = 1.0
	e._value = 2.0

func after_each():
	.after_each()
	progress.free()


func after_all():
	.after_all()
	progress_scene = null


func test_min_value_is_copied_from_need():
	progress.need = e
	add_child(progress)
	simulate(progress, 2, 0.1)
	assert_eq(progress.min_value, e.min_value)
	
	
func test_max_value_is_copied_from_need():
	progress.need = e
	add_child(progress)
	simulate(progress, 2, 0.1)
	assert_eq(progress.max_value, e.max_value)


func test_progress_value_is_inverted_need():
	progress.need = e
	add_child(progress)
	simulate(progress, 1, 0.1)
	assert_eq(progress.value, e.max_value - e._value + e.min_value)


func test_value_is_updated_every_frame():
	progress.need = e
	add_child(progress)
	for i in range(10):
		e._value = i * progress.step + e.min_value
		simulate(progress, 1, 0.1)
		assert_almost_eq(progress.value, e.max_value - e._value + e.min_value, progress.step / 10)
