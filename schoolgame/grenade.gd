extends Area2D

onready var explosion = get_node("grenade_explosion")
var rng = RandomNumberGenerator.new()
var rotation_speed
var velocity = Vector2.ZERO
var speed = 3
func _ready():
	rng.randomize()
	rotation_speed = rng.randf_range(1,5)
	$AnimationPlayer.play("grenade_throw")
	velocity = Vector2(speed , 0)
	

func _physics_process(delta):
	global_position += velocity.rotated(rotation)
	$sprite.global_rotation_degrees += rotation_speed
	


func _on_AnimationPlayer_animation_finished(anim_name):
	set_physics_process(false)
	$sprite.hide()
	$CollisionShape2D.disabled = false
	if Global.OP_mode:
		$CollisionShape2D.scale *= 2
	explode()
	velocity = Vector2.ZERO
	$timer.start()
	
func explode():

	explosion.global_position = global_position
	explosion.emitting = true
	if Global.OP_mode:
		explosion.scale_amount *= 2
	add_child(explosion)
	$explosion.play()
	





func _on_grenade_body_entered(body):
	if "health" in body and Global.can_hit_asparagus_minion:
		body.hit()
		body.health -= 5
		if Global.OP_mode:
			body.health -= 15
		set_physics_process(false)
		
		



func _on_explosion_finished():
	queue_free()


func _on_timer_timeout():
	$CollisionShape2D.disabled = true
