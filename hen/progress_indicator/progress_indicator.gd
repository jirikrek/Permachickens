extends TextureProgress

export var source: Node2D

func _ready():
	hide()	
	set_process(false)


func _process(delta):
	value = 1 - $"..".thirst._value


func _on_Chicken_mouse_entered():
	print("Mouse entered")
	show()
	set_process(true)


func _on_Chicken_mouse_exited():
	hide()
	set_process(false)
