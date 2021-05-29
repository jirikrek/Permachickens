extends KinematicBody2D
class_name Chicken
var water := Water.new()
var food := Food.new()


func drink(resource):
	water.drink(resource)


func eat(resource):
	food.eat(resource)
