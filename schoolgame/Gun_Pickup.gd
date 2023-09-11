extends Area2D


func _physics_process(delta):
	
	if get_overlapping_bodies() and Input.is_action_just_pressed("pickup_item"):
		pass
