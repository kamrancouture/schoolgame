extends Node2D





func _physics_process(delta):
	if $mikes.get_child_count() == 0:
		$boss_mike.show()
		$boss_mike.spawned = true
