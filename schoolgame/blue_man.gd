extends KinematicBody2D

onready var player = get_parent().get_node("Player")
var Bullet = preload("res://enamy_bullet.tscn")
var aggrivated = false
var kill_player = false

func _physics_process(delta):
	look_at(player.global_position)
	
	print(kill_player)
	
	if kill_player == true and not aggrivated:
		aggrivated = true
		$shoot_timer.start()
	





func shoot():
	var bullet = Bullet.instance()
	bullet.global_position = $Position2D.global_position
	bullet.rotation = global_rotation
	get_parent().add_child(bullet)
	
	


	


func _on_shoot_timer_timeout():
	shoot()


func _on_Area2D_area_entered(area):
	kill_player = true
