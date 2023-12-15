extends Sprite

var can_move = true
var speed = 1

func _physics_process(delta):
	
	global_position.y += speed
	
	if Input.is_action_just_pressed("rotate_left"):
		global_rotation_degrees -= 90
	if Input.is_action_just_pressed("rotate_right"):
		global_rotation_degrees += 90
	
	if Input.is_action_pressed("move_left") and can_move:
		can_move = false
		get_parent().get_node("can_move").start()
		global_position.x -= 32
	if Input.is_action_pressed("move_right") and can_move:
		can_move = false
		get_parent().get_node("can_move").start()
		global_position.x += 32
	
