extends KinematicBody2D
onready var player = get_parent().get_node("Player")
var spawned = false

func _physics_process(delta):
	if spawned:
		look_at(player.global_position)
	
