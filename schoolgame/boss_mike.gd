extends KinematicBody2D
onready var player = get_parent().get_node("Player")
var Mike = preload("res://mike_hunt.tscn")
var spawned = false
var can_spawned_mike = false
var health = 15
var damage = 0.1
func _ready():
	set_collision_mask_bit(0 , false)
	set_collision_layer_bit(1 , false)
func _physics_process(delta):
	print(spawned)
	if health <= 0:
		spawned = false
		$Node2D/change_scene.start()
		hide()
	if spawned:
		set_collision_mask_bit(0 , true)
		set_collision_layer_bit(1 , true)
		if not can_spawned_mike:
			
			$Node2D/spawned_mikes.start()
			can_spawned_mike = true
		$Node2D.look_at(player.global_position)
		$big_mikeCollisionShape2D2.global_rotation = $Node2D.global_rotation
		if health <= 0:
			
			set_collision_mask_bit(0 , false)
			set_collision_layer_bit(1 , false)
			hide()
			set_physics_process(false)
func hit():
	pass

func spawned_mike():
	if spawned:
		var mike = Mike.instance()
		Global.mike_hunt_ready = true
		mike.global_position = $Node2D/Position2D.global_position
		get_parent().get_node("mikes").add_child(mike)



func _on_spawned_mikes_timeout():
	if spawned:
		spawned_mike()
		can_spawned_mike = false


func _on_attack_box_body_entered(body):
	pass


func _on_change_scene_timeout():
	get_tree().change_scene("res://asparagus_world.tscn")
