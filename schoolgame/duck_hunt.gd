extends Node2D

var score = 0
var Duck = preload("res://duck.tscn")
var crosshair = preload("res://Assets/kenney_input-prompts-pixel-16/Tiles/tile_0000.png")

var rng = RandomNumberGenerator.new()

var duck_move_right = [
	true,
	false
]

func _ready():
	randomize()
	rng.randomize()
	Input.set_custom_mouse_cursor(crosshair , Input.CURSOR_ARROW , Vector2(8 , 8))

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		$shoot.play()
	$Score_panel/CenterContainer/Score.text = String(score)

func _on_Timer_timeout():
	var duck = Duck.instance()
	duck.global_position.y = rng.randf_range(0,600)
	duck_move_right.shuffle()
	duck.moving_right = duck_move_right.front()
	add_child(duck)
