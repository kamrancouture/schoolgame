extends KinematicBody2D

var Blood_Effect = preload("res://blood_effect.tscn")
var Death_Blood = preload("res://death_blood.tscn")
onready var player = get_parent().get_node("Player")
var Bullet = preload("res://enemy_bullet.tscn")
var aggrivated = false
var kill_player = false
var health = 15
var velocity = Vector2.ZERO

func _ready():
	$AnimatedSprite.play("idle")

func _physics_process(delta):
	
	
	if Global.player_alive:
		if health <= 0:
			var death_blood = Death_Blood.instance()
			death_blood.global_position = global_position
			death_blood.emitting = true
			get_parent().add_child(death_blood)
			queue_free()
		
		look_at(player.global_position)
		
		
		if kill_player == true and not aggrivated:
			aggrivated = true
			$shoot_timer.start()
		$Label.rect_rotation = -rotation
	
	velocity = $AnimatedSprite
	
	move_and_slide(velocity)


func hit():
	var blood_effect = Blood_Effect.instance()
	blood_effect.global_position = global_position
	blood_effect.emitting = true
	get_parent().add_child(blood_effect)


func shoot():
	if Global.player_alive:
		var bullet = Bullet.instance()
		bullet.global_position = $AnimatedSprite/Position2D.global_position
		bullet.rotation = $AnimatedSprite.global_rotation
		get_parent().add_child(bullet)
		$shoot.play()


func _on_shoot_timer_timeout():
	shoot()


func _on_Area2D_area_entered(area):
	$AnimatedSprite.play("aggro")
	kill_player = true
