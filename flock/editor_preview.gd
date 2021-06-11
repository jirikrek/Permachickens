tool
extends Node2D

func _process(delta):
	update()

func _draw():
	if Engine.editor_hint:
		draw_circle(Vector2.ZERO, $"..".radius, Color(1, 0.89, 0.77, 0.3))
