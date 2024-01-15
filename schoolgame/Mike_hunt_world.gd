extends Node2D


func _ready():
	$Line2D.hide()
	$grapple_hook/CollisionShape2D.disabled = true


func _physics_process(delta):
	if $boss_mike.health <= 0:
		$Line2D.show()
		$Line2D.global_position = Vector2.ZERO
		$Line2D.clear_points()
		$Line2D.add_point($Player.global_position)
		$Line2D.add_point($grapple_hook.global_position)
	
	if $mikes.get_child_count() == 0 and $boss_mike.spawned == false:
		$grapple_hook.show()
		$grapple_hook/CollisionShape2D.disabled = false
		$boss_mike.show()
		$boss_mike/big_mikeCollisionShape2D2.disabled = false
		$boss_mike/Node2D/attack_box/big_mikeCollisionShape2D2.disabled = false
		$boss_mike.spawned = true




