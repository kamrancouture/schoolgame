extends Area2D

var duck_type = null
var can_die = false
var moving_right = true
var velocity = Vector2.ZERO
var speed = 10
var Blood_Splatter = preload("res://duck_blood_splatter.tscn")

var rng = RandomNumberGenerator.new()

var ducks = [
	"blue",
	"black",
	"red"
]

func _ready():
	rng.randomize()
	randomize()
	speed = rng.randf_range(5,15)
	if moving_right:
		$duck_type.flip_h = false
		global_position.x = -50
		velocity.x = speed
	else:
		$duck_type.flip_h = true
		global_position.x = 1074
		velocity.x = -speed

	ducks.shuffle()
	duck_type = ducks.front()
	if duck_type == "blue":
		$AnimationPlayer.play("blue_duck")
	elif duck_type == "black":
		$AnimationPlayer.play("black_duck")
	else:
		$AnimationPlayer.play("red_duck")


func _physics_process(delta):
	global_position += velocity
	
	if Input.is_action_just_pressed("shoot") and can_die:
		var blood_splatter = Blood_Splatter.instance()
		blood_splatter.global_position = get_global_mouse_position()
		blood_splatter.emitting = true
		get_parent().add_child(blood_splatter)
		get_parent().score += rng.randi_range(7500 , 25000)
		queue_free()


func _on_duck_mouse_entered():
	can_die = true


func _on_duck_mouse_exited():
	can_die = false
