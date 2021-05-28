extends KinematicBody2D
class_name Chicken
var thirst := Thirst.new()


func drink(resource):
	thirst.drink(resource)
