extends KinematicBody2D


var girl = preload("res://Assets/kenney_top-down-shooter/PNG/Woman Green/womanGreen_hold.png")
var brown_man = preload("res://Assets/kenney_top-down-shooter/PNG/Man Brown/manBrown_hold.png")
var blue_man = preload("res://Assets/kenney_top-down-shooter/PNG/Man Blue/manBlue_hold.png")
var survivor = preload("res://Assets/kenney_top-down-shooter/PNG/Survivor 1/survivor1_hold.png")

var can_hit = true
var Death_Blood = preload("res://death_blood.tscn")
var Blood_Effect = preload("res://blood_effect.tscn")
onready var player = get_parent().get_node("Player")
var aggro = false
var rng = RandomNumberGenerator.new()
var health = 5
var velocity = Vector2.ZERO
var speed = 200
var damage = 0.025
var wander_speed = 1
var rotate_amount : float
var rotate_speed = 3
var rotating = false
onready var navigation_agent = $NavigationAgent2D

onready var looks = [
	blue_man,
	survivor,
	girl,
	brown_man
]



func _ready():
	randomize()
	looks.shuffle()
	$Sprite.texture = looks.front()
	
	rng.randomize()

func _physics_process(delta):
	
	if Global.world == "computer_class":
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
			queue_free()
		
		if aggro:
			navigation_agent.set_target_location(player.global_position)
			velocity = global_position.direction_to(navigation_agent.get_next_location()) * speed
			navigation_agent.set_velocity(velocity)
			$Sprite.look_at(navigation_agent.get_next_location())
		
		
		move_and_slide(velocity)


func hit():
	aggro = true
	var blood_effect = Blood_Effect.instance()
	blood_effect.global_position = global_position
	blood_effect.emitting = true
	get_parent().add_child(blood_effect)

func _on_Area2D_body_entered(body):
	aggro = true


func _on_Area2D_body_exited(body):
	aggro = false


func _on_hit_timer_timeout():
	can_hit = true



