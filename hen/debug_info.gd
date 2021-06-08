extends Area2D

export var hen_path: NodePath
var _hen: Hen

func _ready():
	_hen = get_node(hen_path)	
	hide_indicators()


func _process(delta):
	$WaterNeed.value = 1 - _hen.water._value
	$FoodNeed.value = 1 - _hen.food._value


func _on_mouse_entered():
	show_indicators()


func _on_mouse_exited():
	hide_indicators()


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print(_hen)


func hide_indicators():
	$WaterNeed.hide()
	$FoodNeed.hide()
	set_process(false)


func show_indicators():
	$WaterNeed.show()
	$FoodNeed.show()
	set_process(true)
