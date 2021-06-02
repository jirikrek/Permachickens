extends KinematicBody2D
class_name Chicken
var water := Water.new()
var food := Food.new()
var live = true


func _ready():
	GameOClock.connect("minute_tick", water, "on_game_minute_tick")
	GameOClock.connect("minute_tick", food, "on_game_minute_tick")
	water.connect("died", self, "die")
	food.connect("died", self, "die")
	
	
func drink(resource):
	water.drink(resource)


func eat(resource):
	food.eat(resource)

	
func die():
	live = false
	$AnimatedSprite.rotation_degrees = 90
	set_process(false)
	$BehaviorTree.abort()

