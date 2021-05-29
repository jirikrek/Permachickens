extends Area2D

export var chicken_path: NodePath
var _chicken: Chicken

func _ready():
	_chicken = get_node(chicken_path)	
	hide_indicators()


func _process(delta):
	$WaterNeed.value = 1 - _chicken.water._value
	$FoodNeed.value = 1 - _chicken.food._value


func _on_mouse_entered():
	show_indicators()


func _on_mouse_exited():
	hide_indicators()


func hide_indicators():
	$WaterNeed.hide()
	$FoodNeed.hide()
	set_process(false)


func show_indicators():
	$WaterNeed.show()
	$FoodNeed.show()
	set_process(true)
