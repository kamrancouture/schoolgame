extends KinematicBody2D

export var fire_rate = 0.2
var Player_Bullet = preload("res://player_bullet.tscn")
var can_shoot = true
var gun_in_hand = false
var velocity = Vector2.ZERO
var speed = 450
var rng = RandomNumberGenerator.new()

func _ready():
	$AnimatedSprite.play("idle")

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
	
	
	if Input.is_action_pressed("shoot") and can_shoot and gun_in_hand:
		can_shoot = false
		var player_bullet = Player_Bullet.instance()
		player_bullet.global_position = $bullet_spawn.global_position
		player_bullet.global_rotation = global_rotation
		get_parent().add_child(player_bullet)
		$fire_rate.start(fire_rate)
		


func _on_fire_rate_timeout():
	can_shoot = true
