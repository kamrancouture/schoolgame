extends Node2D

var cursor = preload("res://Assets/kenney_crosshair-pack/PNG/Outline Retina/crosshair173.png")

func _ready():
	Input.set_custom_mouse_cursor(cursor , Input.CURSOR_ARROW , Vector2(72,72))
