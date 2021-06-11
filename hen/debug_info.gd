extends Area2D

export var hen_path: NodePath
var _hen: Hen


func _enter_tree():
	_hen = get_node(hen_path)	
	$WaterNeed.need = _hen.water
	$FoodNeed.need = _hen.food


func _ready():
	hide_indicators()


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
