tool
extends Node2D

export var chickens := 5 setget set_chickens
export var chickenScene : Resource
export var radius := 40 setget set_radius

func _ready():
	regenerate()


func regenerate():
	remove_hens()
	create_hens()


func remove_hens():
	for child in get_children():
		if child.is_in_group("Hens"):
			remove_child(child)
		

func create_hens():
	if chickenScene == null:
		return
		
	for i in range(chickens):
		var chick:Node2D = chickenScene.instance()
		chick.position = position + Vector2(randf() * radius - radius / 2, randf() * radius - radius / 2)
		get_parent().call_deferred("add_child", chick)


func set_radius(new_radius):
	radius = new_radius
	regenerate()


func set_chickens(new_chickens):
	chickens = new_chickens
	regenerate()
