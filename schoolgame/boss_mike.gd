extends KinematicBody2D
onready var player = get_parent().get_node("Player")
var spawned = false
var health = 3
func _physics_process(delta):
	print($big_mikeCollisionShape2D2.disabled)
	if spawned:
		$Sprite.look_at(player.global_position)
		if health <= 0:
#			$attack_box/big_mikeCollisionShape2D2.disabled = true
#			$big_mikeCollisionShape2D2.disabled = true
			hide()
			set_physics_process(false)
func hit():
	pass

