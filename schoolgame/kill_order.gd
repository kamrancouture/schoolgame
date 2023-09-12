extends KinematicBody2D

onready var player = get_parent().get_node("Player")
var speed = 1
var look = true
var super_speed = 10
var fast_speed = true
var time = true
func _physics_process(delta):
	
	if look == true:
		look_at(player.global_position)
		global_position += Vector2(speed , 0).rotated(rotation)
		
	if fast_speed == true:
		look = false
		global_position += Vector2(super_speed , 0).rotated(rotation)
		$stop_running.start()
		


	print(fast_speed)

	



	


func _on_run_timer_timeout():
	look = true
	fast_speed = false
	


func _on_stop_running_timeout():
	fast_speed = true
	
