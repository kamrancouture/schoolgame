extends Area2D

onready var explosion = get_node("grenade_explosion")
var rng = RandomNumberGenerator.new()
var rotation_speed
var velocity = Vector2.ZERO
var speed = 2
func _ready():
	rng.randomize()
	rotation_speed = rng.randf_range(1,5)
	$AnimationPlayer.play("grenade_throw")
	velocity = Vector2(speed , 0)
	

func _physics_process(delta):
	$sprite.global_rotation_degrees += rotation_speed
	global_position += velocity.rotated(rotation)


func _on_AnimationPlayer_animation_finished(anim_name):
	set_physics_process(false)
	$sprite.hide()
	$CollisionShape2D.disabled = false
	explode()
	velocity = Vector2.ZERO
	
	
func explode():

	explosion.global_position = global_position
	explosion.emitting = true
	add_child(explosion)
	$explosion.play()





func _on_grenade_body_entered(body):
	if "health" in body:
		body.hit()
		body.health -= 5
		set_physics_process(false)
		



func _on_explosion_finished():
	queue_free()
