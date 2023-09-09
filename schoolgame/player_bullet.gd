extends Area2D

var Blood_Effect = preload("res://blood_effect.tscn")
var speed = 15
var damage = 1

func _physics_process(delta):
	global_position += Vector2(speed , 0).rotated(rotation)


func _on_player_bullet_body_entered(body):
	var blood_effect = Blood_Effect.instance()
	blood_effect.global_position = global_position
	blood_effect.emitting = true
	get_parent().add_child(blood_effect)
	body.health -= 1
	set_physics_process(false)
	hide()
	$hit_enemy.play()
	yield($hit_enemy , "finished")
	queue_free()
