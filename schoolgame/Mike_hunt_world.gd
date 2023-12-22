extends Node2D


func _ready():
	$grapple_hook/CollisionShape2D.disabled = true


func _physics_process(delta):
	if $mikes.get_child_count() == 0 and $boss_mike.spawned == false:
		$grapple_hook.show()
		$grapple_hook/CollisionShape2D.disabled = false
		print("hello")
		$boss_mike.show()
		$boss_mike/big_mikeCollisionShape2D2.disabled = false
		$boss_mike/attack_box/big_mikeCollisionShape2D2.disabled = false
		$boss_mike.spawned = true
