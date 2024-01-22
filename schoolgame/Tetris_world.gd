extends Node2D

var can_spawn = true


var I_Block = preload("res://Assets/tetris/pieces/I-Block.png")
var T_Block = preload("res://Assets/tetris/pieces/T_Block.png")
var O_Block = preload("res://O_Block.tscn")
var S_Block = preload("res://Assets/tetris/pieces/S_Block.png")
var Z_Block = preload("res://Assets/tetris/pieces/Z_Block.png")
var J_Block = preload("res://J_Block.tscn")
var L_Block = preload("res://Assets/tetris/pieces/L_Block.png")


var pieces = [
	O_Block,
	O_Block,
	O_Block,
	O_Block,
	J_Block,
	J_Block,
	J_Block
]


func _physics_process(delta):
	if can_spawn:
		can_spawn = false
		pieces.shuffle()
		var Piece = pieces.front()
		var piece = Piece.instance()
		if piece.piece == "O":
			piece.global_position = Vector2(472 , 32)
		elif piece.piece == "J":
			piece.global_position = Vector2(488 , -32)
		add_child(piece)







