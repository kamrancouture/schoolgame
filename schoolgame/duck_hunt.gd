extends Node2D

var lives = 5
var score = 0
var Duck = preload("res://duck.tscn")
var crosshair = preload("res://Assets/kenney_crosshair-pack/PNG/Outline Retina/crosshair037.png")

var rng = RandomNumberGenerator.new()

var duck_move_right = [
	true,
	false
]

func _ready():
	randomize()
	rng.randomize()
	Input.set_custom_mouse_cursor(crosshair , Input.CURSOR_ARROW , Vector2(72 , 72))

func _physics_process(delta):
	$Timer.wait_time *= .999
	
	if Input.is_action_just_pressed("shoot"):
		$shoot.play()
	$Score_panel/CenterContainer/Score.text = String(score)

func _on_Timer_timeout():
	var duck = Duck.instance()
	duck.global_position.y = rng.randf_range(0,600)
	duck_move_right.shuffle()
	duck.moving_right = duck_move_right.front()
	add_child(duck)
