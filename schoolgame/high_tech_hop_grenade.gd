extends KinematicBody2D

onready var player = get_parent().get_node("high_tech_hop_player")
var shotpower = 3
onready var explosion = get_node("grenade_explosion")
var velocity = Vector2.ZERO
var gravity = 35

func _ready():
	$AnimationPlayer.play("throw")
 
func _physics_process(delta):
	velocity.y += gravity
	move_and_slide(velocity)


func _on_AnimationPlayer_animation_finished(anim_name):
	$explosion_sound.play()
	player.shot_power = shotpower
	player.grenade_shot_position = global_position
	$disappear_timer.start()
	$Sprite.hide()
	$CollisionShape2D.disabled = true
	explosion.emitting = true
	set_physics_process(false)




func _on_explosion_sound_finished():
	queue_free()
