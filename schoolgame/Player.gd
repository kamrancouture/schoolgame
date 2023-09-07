extends KinematicBody2D


var velocity = Vector2.ZERO
var speed = 600

func _physics_process(delta):
	velocity = Input.get_vector("a_click" , "d_click" , "w_click" , "s_click") * speed
	move_and_slide(velocity)
	look_at(get_global_mouse_position())
	
