extends Node2D

onready var player = get_node("Player")

func _ready():
	Input.set_custom_mouse_cursor(null)
	$dead_ducks.hide()

func _physics_process(delta):
	
	if Global.duck_hunt_defeated:
		$dead_ducks.show()
