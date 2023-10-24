extends Area2D

onready var explosion = get_node("grenade_explosion")

func _ready():
	$Timer.start()
func _on_AnimationPlayer_animation_finished(anim_name):
	$sprite.hide()
	$CollisionShape2D.disabled = false
	explode()
	
	
	
func explode():

	explosion.global_position = global_position
	explosion.emitting = true
	add_child(explosion)


func _on_Timer_timeout():
	$AnimationPlayer.play("grenade_throw")





func _on_grenade_body_entered(body):
	pass
