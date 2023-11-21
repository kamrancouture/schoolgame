extends KinematicBody2D



var can_hit = true
var Death_Blood = preload("res://zombie_death_effect.tscn")
var Blood_Effect = preload("res://zombie_blood_effect.tscn")
onready var player = get_parent().get_node("Player")
var aggro = false
var rng = RandomNumberGenerator.new()
var health = 200
var velocity = Vector2.ZERO
var speed = 250
var damage = 0.03
var wander_speed = 1
var rotate_amount : float
var rotate_speed = 3
var rotating = false
onready var navigation_agent = $NavigationAgent2D

func _ready():
	$AnimatedSprite.play("idle")
	rng.randomize()


func _physics_process(delta):
	
	if Global.world == "computer_class":
		$AnimatedSprite.play("aggro")
		aggro = true
	
	if Global.player_alive:
		$name_teg.rect_rotation = -rotation
		if not aggro:
			velocity = Vector2(wander_speed , 0).rotated(rotation)
			if rotate_amount > 0:
				rotate_amount -= rotate_speed
				global_rotation += deg2rad(rotate_speed)
		if $attack_box.get_overlapping_bodies():
			player.health -= damage
			if can_hit:
				can_hit = false
				$hit_timer.start()
				player.hit()
		if health <= 0:
			var death_blood = Death_Blood.instance()
			death_blood.global_position = global_position
			death_blood.emitting = true
			get_parent().add_child(death_blood)
			Global.students_alive -= 1
			queue_free()
		
		if aggro:
			navigation_agent.set_target_location(player.global_position)
			velocity = global_position.direction_to(navigation_agent.get_next_location()) * speed
			navigation_agent.set_velocity(velocity)
			$AnimatedSprite.look_at(navigation_agent.get_next_location())
		
		
		move_and_slide(velocity)


func hit():
	aggro = true
	var blood_effect = Blood_Effect.instance()
	blood_effect.global_position = global_position
	blood_effect.emitting = true
	get_parent().add_child(blood_effect)

func _on_Area2D_body_entered(body):
	$AnimatedSprite.play("walking")
	aggro = true


func _on_Area2D_body_exited(body):
	$AnimatedSprite.play("idle")
	aggro = false


func _on_hit_timer_timeout():
	can_hit = true


