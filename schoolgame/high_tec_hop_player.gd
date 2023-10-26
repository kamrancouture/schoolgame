extends KinematicBody2D

var velocity = Vector2(0,0)
var speed = 25
var gravity = 35
func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("a_click"):
		velocity.x -= speed
	elif Input.is_action_pressed("d_click"):
		velocity.x += speed

	velocity = move_and_slide(velocity , Vector2.UP)
	velocity.y = velocity.y + gravity
