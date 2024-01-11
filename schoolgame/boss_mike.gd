extends KinematicBody2D
onready var player = get_parent().get_node("Player")
var Mike = preload("res://mike_hunt.tscn")
var spawned = false
var can_spawned_mike = false
var health = 3
func _ready():
	set_collision_mask_bit(0 , false)
	set_collision_layer_bit(1 , false)
func _physics_process(delta):
	print(spawned)
	if health < 0:
		spawned = false
		queue_free()
	if spawned:
		set_collision_mask_bit(0 , true)
		set_collision_layer_bit(1 , true)
		if not can_spawned_mike:
			$spawned_mikes.start()
			can_spawned_mike = true
		look_at(player.global_position)
		if health <= 0:
			
			set_collision_mask_bit(0 , false)
			set_collision_layer_bit(1 , false)
			hide()
			set_physics_process(false)
func hit():
	pass

func spawned_mike():
	var mike = Mike.instance()
	Global.mike_hunt_ready = true
	mike.global_position = $Position2D.global_position
	get_parent().get_node("mikes").add_child(mike)
	


func _on_spawned_mikes_timeout():
	if spawned:
		spawned_mike()
	can_spawned_mike = false
