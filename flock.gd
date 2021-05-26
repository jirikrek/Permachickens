extends Node2D

export var chickens = 5
export var chickenScene : Resource
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(chickens):
		var chick:CollisionObject2D = chickenScene.instance()
		chick.position = Vector2(randf() * 40 - 20, randf() * 40 - 20)
		add_child(chick)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
