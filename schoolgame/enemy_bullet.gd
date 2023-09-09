extends Area2D

var Blood_Effect = preload("res://blood_effect.tscn")
var speed = 10
var damage = 1

func _physics_process(delta):
	global_position += Vector2(speed , 0).rotated(rotation)
	



func _on_enemy_bullet_body_entered(body):
	body.health -= damage
	body.hit()
	queue_free()
