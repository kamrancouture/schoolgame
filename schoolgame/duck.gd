extends Area2D

var can_die = false
var moving_right = true
var velocity = Vector2.ZERO
var speed = 10
var Blood_Splatter = preload("res://duck_blood_splatter.tscn")

var ducks = [
	preload("res://icon.png"),
	preload("res://Assets/kenney_top-down-shooter/PNG/Robot 1/robot1_gun.png"),
	preload("res://Assets/kenney_top-down-shooter/PNG/Hitman 1/hitman1_gun.png")
]

var rng = RandomNumberGenerator.new()

func _ready():
	if moving_right:
		global_position.x = -50
		velocity.x = speed
	else:
		global_position.x = 1074
		velocity.x = -speed
	rng.randomize()
	randomize()
	ducks.shuffle()
	$duck_type.texture = ducks.front()


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
