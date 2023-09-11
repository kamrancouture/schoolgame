extends Area2D

onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	
	if get_overlapping_bodies():
		$Press_E.show()
#		$Press
		if Input.is_action_just_pressed("pickup_item"):
			pass
	else:
		$Press_E.hide()


