extends KinematicBody2D

var gun_in_hand = false
var velocity = Vector2.ZERO
var speed = 600

func _physics_process(delta):
	velocity = Input.get_vector("a_click" , "d_click" , "w_click" , "s_click") * speed
	move_and_slide(velocity)
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("gun") and not gun_in_hand:
		gun_in_hand = true
		speed /= 1.5
		$AnimatedSprite.play("pistol")
	elif Input.is_action_just_pressed("gun"):
		gun_in_hand = false
		speed *= 1.5
		$AnimatedSprite.play("idle")

