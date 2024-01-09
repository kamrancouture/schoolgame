extends Sprite

var can_move = true
var speed = 1
var push_down_speed = 3

func _physics_process(delta):
	
#	if not Input.is_action_pressed("move_down"):
#		global_position.y += speed
#	else:
#		global_position.y += push_down_speed
	
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
	


func _on_move_down_timeout():
	global_position.y += 32
	if Input.is_action_pressed("tetris_push_down"):
		get_parent().get_node("move_down").start(0.1)
	else:
		get_parent().get_node("move_down").start(0.5)
	


func _on_can_move_timeout():
	can_move = true
