extends Node2D

var restarting = false
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
	
	if not restarting:
		$mistake_panel/CenterContainer/mistakes_left.text = String(lives)
	
	if lives <= 0 and not restarting:
		restarting = true
		$restart_timer.start()
	
	$Timer.wait_time *= .999
	
	if Input.is_action_just_pressed("shoot"):
		$shoot.play()
	$Score_panel/CenterContainer/Score.text = String(score)

func _on_Timer_timeout():
	if not restarting:
		var duck = Duck.instance()
		duck.global_position.y = rng.randf_range(30,570)
		duck_move_right.shuffle()
		duck.moving_right = duck_move_right.front()
		add_child(duck)

func restart():
	restarting = false
	lives = 5
	score = 0
	$Timer.wait_time = 3

func _on_left_wall_area_entered(area):
	if not area.moving_right:
		area.queue_free()
		lives -= 1


func _on_right_wall_area_entered(area):
	if area.moving_right:
		area.queue_free()
		lives -= 1


func _on_restart_timer_timeout():
	restart()
