extends KinematicBody2D

onready var player = get_parent().get_node("Player")
var speed = 1
var look = true
var super_speed = 10
var bullet_speed = 0.0001
var Bullet_order = preload("res://kill_order_bullet1.tscn")
var fast_speed = false
var time = true
onready var player_bullet 
var health = 5

func _physics_process(delta):
	
	if health <= 0:
		queue_free()
	
	
	
	if look == true:
		look_at(player.global_position)
		global_position += Vector2(speed , 0).rotated(rotation)
		$fire_running.start()
	if fast_speed == true:
		look = false
		global_position += Vector2(super_speed , 0).rotated(rotation)

func shoot():
	var bullet_order = Bullet_order.instance()
	bullet_order.global_position += Vector2(bullet_speed , 0).rotated(rotation)
	bullet_order.global_position = $right_shooter.global_position
	bullet_order.global_rotation = $right_shooter.global_rotation
	get_parent().add_child(bullet_order)

func shoot2():
	var bullet_order = Bullet_order.instance()
	bullet_order.global_position += Vector2(bullet_speed , 0).rotated(rotation)
	bullet_order.global_position = $left_shooter.global_position
	bullet_order.global_rotation = $left_shooter.global_rotation
	get_parent().add_child(bullet_order)
func shoot3():
	var bullet_order = Bullet_order.instance()
	bullet_order.global_position += Vector2(bullet_speed , 0).rotated(rotation)
	bullet_order.global_position = $middle_shooter.global_position
	bullet_order.global_rotation = $middle_shooter.global_rotation
	get_parent().add_child(bullet_order)

func _on_run_timer_timeout():
	look = true
#	fast_speed = false

func _on_fire_running_timeout():
	shoot()
	shoot2()
	shoot3()
func hit():
	pass

func _on_Area2D_body_entered(body):
	print("hi")
	
