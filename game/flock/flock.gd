tool
extends Node2D

export var hens := 5 setget set_hens
export var henScene: PackedScene
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
	if henScene == null:
		return
		
	for i in range(hens):
		var hen:Node2D = henScene.instance()
		hen.position = position + Vector2(randf() * radius - radius / 2, randf() * radius - radius / 2)
		get_parent().call_deferred("add_child", hen)


func set_radius(new_radius):
	radius = new_radius
	regenerate()


func set_hens(new_hens):
	hens = new_hens
	regenerate()
