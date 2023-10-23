extends Area2D

var Explosion = preload("res://grenade_explosion.tscn")

func _ready():
	$Timer.start()
func _on_AnimationPlayer_animation_finished(anim_name):
	$sprite.hide()
	$CollisionShape2D.disabled = false
	explode()
	
	
	
func explode():
	var explosion = Explosion.instance()
	explosion.global_position = global_position
	explosion.emitting = true
	add_child(explosion)


func _on_Timer_timeout():
	$AnimationPlayer.play("grenade_throw")
