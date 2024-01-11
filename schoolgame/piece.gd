extends Sprite

var piece_placed = false
var piece_on_bottom = false
var can_move_left = true
var can_move_right = true
var can_move = true
var speed = 1
var push_down_speed = 3

var Tetris_Block = preload("res://tetris_block.tscn")
var piece = null

func _physics_process(delta):
	
	if Input.is_action_pressed("tetris_push_down") and $move_down.time_left > .1:
		$move_down.start(0.1)
	
	if Input.is_action_just_pressed("rotate_left"):
		global_rotation_degrees -= 90
	if Input.is_action_just_pressed("rotate_right"):
		global_rotation_degrees += 90
	
	if Input.is_action_pressed("move_left") and can_move and can_move_left:
		can_move = false
		$can_move.start()
		global_position.x -= 32
	if Input.is_action_pressed("move_right") and can_move and can_move_right:
		can_move = false
		$can_move.start()
		global_position.x += 32
	


func _on_move_down_timeout():
	if not piece_placed:
		if piece_on_bottom:
			place()
		else:
			global_position.y += 32
			if Input.is_action_pressed("tetris_push_down"):
				$move_down.start(0.1)
			else:
				$move_down.start(0.5)
	


func place():
	get_parent().can_spawn = true
	piece_placed = true
	set_physics_process(false)
	if piece == "O":
		var tetris_block_1 = Tetris_Block.instance()
		tetris_block_1.global_position = global_position + Vector2(-16 , -16)
		var tetris_block_2 = Tetris_Block.instance()
		tetris_block_2.global_position = global_position + Vector2(-16 , 16)
		var tetris_block_3 = Tetris_Block.instance()
		tetris_block_3.global_position = global_position + Vector2(16 , -16)
		var tetris_block_4 = Tetris_Block.instance()
		tetris_block_4.global_position = global_position + Vector2(16 , 16)
		get_parent().add_child(tetris_block_1)
		get_parent().add_child(tetris_block_2)
		get_parent().add_child(tetris_block_3)
		get_parent().add_child(tetris_block_4)
		queue_free()


func _on_can_move_timeout():
	can_move = true


func _on_left_wall_detector_area_entered(area):
	can_move_left = false


func _on_right_wall_detector_area_entered(area):
	can_move_right = false


func _on_left_wall_detector_area_exited(area):
	can_move_left = true


func _on_right_wall_detector_area_exited(area):
	can_move_right = true


func _on_floor_detector_area_entered(area):
	piece_on_bottom = true


func _on_floor_detector_area_exited(area):
	piece_on_bottom = false
