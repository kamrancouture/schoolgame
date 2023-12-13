extends Node2D





func _physics_process(delta):
	if $mikes.get_child_count() == 0:
		print("hello")
