extends KinematicBody2D
onready var player = get_parent().get_node("Player")
var spawned = false
var health = 3
func _ready():
	set_collision_mask_bit(0 , false)
	set_collision_layer_bit(1 , false)
func _physics_process(delta):
	print($big_mikeCollisionShape2D2.disabled)
	if spawned:
		set_collision_mask_bit(0 , true)
		set_collision_layer_bit(1 , true)
		$Sprite.look_at(player.global_position)
		if health <= 0:
			set_collision_mask_bit(0 , false)
			set_collision_layer_bit(1 , false)
			hide()
			set_physics_process(false)
func hit():
	pass

