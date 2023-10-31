extends KinematicBody2D

var shot_power = 0
var shot_position = Vector2.ZERO
var velocity = Vector2(0,0)
var speed = 50
var jumpforce = 500
var gravity = 35
onready var gun = $high_tech_hop_gun

func _ready():
	if not Global.player_hotbar == null:
		$hotbar.items = Global.player_hotbar
	
	

func _physics_process(delta):
	if is_on_floor():
		velocity.x = Input.get_axis("a_click" , "d_click") * speed
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jumpforce
	
	velocity.y += gravity
	
	gun.global_position = global_position + (get_global_mouse_position() - global_position).normalized() * 50
	velocity += (global_position - shot_position).normalized() * shot_power
	shot_power = 0
	shot_position = Vector2.ZERO
	
	
	velocity = move_and_slide(velocity , Vector2.UP)
	

