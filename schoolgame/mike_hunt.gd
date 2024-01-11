extends KinematicBody2D


var can_hit = true
var Death_Blood = preload("res://zombie_death_effect.tscn")
var Blood_Effect = preload("res://zombie_blood_effect.tscn")
onready var player = get_parent().get_parent().get_node("Player")
var aggro = false
var rng = RandomNumberGenerator.new()
var health = 1
var velocity = Vector2.ZERO
var speed = 335
var damage = 0.025
var wander_speed = 1
var rotate_amount : float
var rotate_speed = 3
var rotating = false
var set_sprite = false
onready var navigation_agent = $NavigationAgent2D

func _ready():
	if Global.mike_hunt_ready:
		aggro = true
	$AnimatedSprite.play("hide")
	rng.randomize()
	$name_tag.hide()

func _physics_process(delta):
	if $AnimatedSprite.animation == "hide":
		$mikeCollisionShape2D.disabled = true
		$big_mikeCollisionShape2D2.disabled = true
	move_and_slide(velocity)
	
	
	if Global.player_alive:
		$name_tag.rect_rotation = -rotation
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
			get_parent().get_parent().add_child(death_blood)
			Global.students_alive -= 1
			queue_free()
		
		if aggro:
			$name_tag.show()
			if rng.randf_range(0,100) < 26 and not set_sprite:
				health += 7
				damage += 0.5
				speed += 65
				set_sprite = true
				$AnimatedSprite.play("big_mike")
				$mikeCollisionShape2D.disabled = true
				$big_mikeCollisionShape2D2.disabled = false
				$attack_box/mikeCollisionShape2D.disabled = true
			elif not set_sprite:
				set_sprite = true
				$AnimatedSprite.play("default")
				$big_mikeCollisionShape2D2.disabled = true
				$mikeCollisionShape2D.disabled = false
				$attack_box/big_mikeCollisionShape2D2.disabled = true
			navigation_agent.set_target_location(player.global_position)
			velocity = global_position.direction_to(navigation_agent.get_next_location()) * speed
			navigation_agent.set_velocity(velocity)
			$AnimatedSprite.look_at(navigation_agent.get_next_location())
		
		
		


func hit():
	aggro = true
	var blood_effect = Blood_Effect.instance()
	blood_effect.global_position = global_position
	blood_effect.emitting = true
	get_parent().get_parent().add_child(blood_effect)

func _on_Area2D_body_entered(body):
	$AnimatedSprite.play("aggro")
	aggro = true





func _on_hit_timer_timeout():
	can_hit = true


