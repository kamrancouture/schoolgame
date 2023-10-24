extends Area2D

onready var explosion = get_node("grenade_explosion")
var rng = RandomNumberGenerator.new()
var rotation_speed

func _ready():
	rng.randomize()
	rotation_speed = rng.randf_range(1,5)
	$Timer.start()
	print(rotation_speed)

func _physics_process(delta):
	global_rotation_degrees += rotation_speed

func _on_AnimationPlayer_animation_finished(anim_name):
	set_physics_process(false)
	$sprite.hide()
	$CollisionShape2D.disabled = false
	explode()
	
	
	
func explode():

	explosion.global_position = global_position
	explosion.emitting = true
	add_child(explosion)
	$explosion.play()

func _on_Timer_timeout():
	$AnimationPlayer.play("grenade_throw")





func _on_grenade_body_entered(body):
	if "health" in body:
		body.hit()
		body.health -= 5
		set_physics_process(false)
		$hit_enemy.play()
		yield($hit_enemy , "finished")



func _on_explosion_finished():
	queue_free()
