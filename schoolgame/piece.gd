extends Sprite

var move_down = false
var piece_placed = false
var piece_on_bottom = false
var can_move_left = true
var can_move_right = true
var can_move = true
var speed = 1
var push_down_speed = 3

var Tetris_Block = preload("res://tetris_block.tscn")
var piece = "O"

func _physics_process(delta):
	
	detect_walls()
	
	if move_down and not piece_on_bottom:
			move_down = false
			global_position.y += 32
	
	
	if Input.is_action_pressed("tetris_push_down") and $move_down.time_left > .1:
		$move_down.start(0.1)
	
	if Input.is_action_just_pressed("rotate_left"):
		global_rotation_degrees -= 90
	if Input.is_action_just_pressed("rotate_right"):
		global_rotation_degrees += 90
	
	detect_walls()
	
	if Input.is_action_pressed("move_left") and can_move and can_move_left:
		can_move = false
		$can_move.start()
		global_position.x -= 32
	if Input.is_action_pressed("move_right") and can_move and can_move_right:
		can_move = false
		$can_move.start()
		global_position.x += 32


func detect_walls():
	piece_on_bottom = false
	can_move_left = true
	can_move_right = true
	if $wall_detector_1.get_overlapping_areas():
		var detected_wall = $wall_detector_1.get_overlapping_areas().front()
		if detected_wall.name == "top_side" or detected_wall.name == "tetris_floor":
			piece_on_bottom = true
		elif detected_wall.name == "right_side" or detected_wall.name == "tetris_left_wall":
			can_move_left = false
		elif detected_wall.name == "left_side" or detected_wall.name == "tetris_right_wall":
			can_move_right = false
	
	if $wall_detector_2.get_overlapping_areas():
		var detected_wall = $wall_detector_2.get_overlapping_areas().front()
		if detected_wall.name == "top_side" or detected_wall.name == "tetris_floor":
			piece_on_bottom = true
		elif detected_wall.name == "right_side" or detected_wall.name == "tetris_left_wall":
			can_move_left = false
		elif detected_wall.name == "left_side" or detected_wall.name == "tetris_right_wall":
			can_move_right = false
	
	if $wall_detector_3.get_overlapping_areas():
		var detected_wall = $wall_detector_3.get_overlapping_areas().front()
		if detected_wall.name == "top_side" or detected_wall.name == "tetris_floor":
			piece_on_bottom = true
		elif detected_wall.name == "right_side" or detected_wall.name == "tetris_left_wall":
			can_move_left = false
		elif detected_wall.name == "left_side" or detected_wall.name == "tetris_right_wall":
			can_move_right = false
	
	if $wall_detector_4.get_overlapping_areas():
		var detected_wall = $wall_detector_4.get_overlapping_areas().front()
		if detected_wall.name == "top_side" or detected_wall.name == "tetris_floor":
			piece_on_bottom = true
		elif detected_wall.name == "right_side" or detected_wall.name == "tetris_left_wall":
			can_move_left = false
		elif detected_wall.name == "left_side" or detected_wall.name == "tetris_right_wall":
			can_move_right = false


func _on_move_down_timeout():
	if not piece_placed:
		detect_walls()
		if piece_on_bottom:
			place()
		else:
			move_down = true
			if Input.is_action_pressed("tetris_push_down"):
				$move_down.start(0.1)
			else:
				$move_down.start(0.5)
	


func place():
	get_parent().can_spawn = true
	piece_placed = true
	set_physics_process(false)
	var tetris_block_1 = Tetris_Block.instance()
	tetris_block_1.global_position = $block_1_spawn.global_position
	var tetris_block_2 = Tetris_Block.instance()
	tetris_block_2.global_position = $block_2_spawn.global_position
	var tetris_block_3 = Tetris_Block.instance()
	tetris_block_3.global_position = $block_3_spawn.global_position
	var tetris_block_4 = Tetris_Block.instance()
	tetris_block_4.global_position = $block_4_spawn.global_position
	get_parent().add_child(tetris_block_1)
	get_parent().add_child(tetris_block_2)
	get_parent().add_child(tetris_block_3)
	get_parent().add_child(tetris_block_4)
	queue_free()





func _on_can_move_timeout():
	can_move = true
