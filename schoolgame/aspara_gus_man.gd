extends KinematicBody2D

var Asparagus_minion = preload("res://asparagus_minion.tscn")
var can_hit = true
var Death_Blood = preload("res://zombie_death_effect.tscn")
var Blood_Effect = preload("res://zombie_blood_effect.tscn")
onready var player = get_parent().get_node("Player")
var aggro = false
var rng = RandomNumberGenerator.new()
var health = 100
var velocity = Vector2.ZERO
var speed = 500
var damage = 0.03
var wander_speed = 1
var rotate_amount : float
var rotate_speed = 3
var rotating = false
onready var navigation_agent = $NavigationAgent2D

var can_spawn = true
var chasing = true
var spawning = false

func _ready():
	aggro = true
	$AnimatedSprite.play("idle")
	rng.randomize()
	
func _physics_process(delta):
	
	if Global.player_alive:
		$name_teg.rect_rotation = -rotation
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
		
		if aggro and chasing:
			navigation_agent.set_target_location(player.global_position)
			velocity = global_position.direction_to(navigation_agent.get_next_location()) * speed
			navigation_agent.set_velocity(velocity)
			$AnimatedSprite.look_at(navigation_agent.get_next_location())
			move_and_slide(velocity)
		elif spawning:
			if can_spawn:
				can_spawn = false
				$spawn_timer.start(rng.randf_range(0.15 , 1.5))
			$AnimatedSprite.look_at(player.global_position)


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




func _on_spawn_timer_timeout():
	can_spawn = true
	var asparagus_minion = Asparagus_minion.instance()
	asparagus_minion.player = player
	asparagus_minion.get_node("AnimatedSprite").show()
	asparagus_minion.get_node("AnimatedSprite").play("aggro")
	asparagus_minion.aggro = true
	asparagus_minion.global_position = global_position
	get_parent().get_node("asparagus_minions").add_child(asparagus_minion)

func _on_phase_timer_timeout():
	if chasing:
		$phase_timer.start()
		$AnimatedSprite.play("idle")
		chasing = false
		spawning = true
	elif spawning:
		$phase_timer.start()
		$AnimatedSprite.play("walking")
		spawning = false
		chasing = true
		
