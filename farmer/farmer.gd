extends KinematicBody2D
class_name Farmer
var move := Vector2.ZERO
var iso = Vector2(1, 0.5)

var energy := Energy.new()

export var speed = 20

func _ready():
	Globals.game_o_clock.connect("minute_tick", energy, "on_game_minute_tick")
	pass

func _process(delta):
	move = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		move += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		move += Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		move += Vector2.UP
	if Input.is_action_pressed("ui_down"):
		move += Vector2.DOWN
	
	
	$AnimatedSprite.animation = "walk" if move.length() > 0 else "idle"
	
	move_and_slide(move.normalized() * iso * speed, Vector2.ZERO, true, 1, deg2rad(25))
