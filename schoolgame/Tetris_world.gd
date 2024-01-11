extends Node2D

var can_spawn = true

var Piece = preload("res://tetris_piece.tscn")

var I_Block = preload("res://Assets/tetris/pieces/I-Block.png")
var T_Block = preload("res://Assets/tetris/pieces/T_Block.png")
var O_Block = preload("res://Assets/tetris/pieces/O_Block.png")
var S_Block = preload("res://Assets/tetris/pieces/S_Block.png")
var Z_Block = preload("res://Assets/tetris/pieces/Z_Block.png")
var J_Block = preload("res://Assets/tetris/pieces/J_Block.png")
var L_Block = preload("res://Assets/tetris/pieces/L_Block.png")


var pieces = [
	"O",
	"O",
	"O",
	"O",
	"O",
	"O",
	"O"
]


func _physics_process(delta):
	if can_spawn:
		can_spawn = false
		var piece = Piece.instance()
		pieces.shuffle()
		piece.piece = pieces.front()
		if piece.piece == "O":
			piece.global_position = Vector2(472 , 32)
			add_child(piece)








