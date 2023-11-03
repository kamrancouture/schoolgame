extends KinematicBody2D

var shot_power = 0
var shot_position = Vector2.ZERO
var velocity = Vector2(0,0)
var speed = 50
var jumpforce = 500
var gravity = 35

var dog_selected = false

onready var get_out = $high_tech_hop_get_out
onready var gun = $high_tech_hop_gun

onready var hotbar = $CanvasLayer/hotbar
var selected_item_index : int
var is_dragging_item = false
var first_item_selected = false
var first_item_selected_info = [
	null,
	"item",
	null,
]

func _ready():
	
	
	
	
	if not Global.player_hotbar == null:
		hotbar.items = Global.player_hotbar
	else:
		hotbar.items = Global.player_items_cheat
	

func _physics_process(delta):
	
	
	
	if Input.is_action_just_pressed("hotbar_1"):
		selected_item_index = 0
		hotbar.select(0)
	elif Input.is_action_just_pressed("hotbar_2"):
		selected_item_index = 1
		hotbar.select(1)
	elif Input.is_action_just_pressed("hotbar_3"):
		selected_item_index = 2
		hotbar.select(2)
	elif Input.is_action_just_pressed("hotbar_4"):
		selected_item_index = 3
		hotbar.select(3)
	elif Input.is_action_just_pressed("hotbar_5"):
		selected_item_index = 4
		hotbar.select(4)
	elif Input.is_action_just_pressed("hotbar_6"):
		selected_item_index = 5
		hotbar.select(5)
	elif Input.is_action_just_pressed("hotbar_7"):
		selected_item_index = 6
		hotbar.select(6)
	elif Input.is_action_just_pressed("hotbar_8"):
		selected_item_index = 7
		hotbar.select(7)
	elif Input.is_action_just_pressed("hotbar_9"):
		selected_item_index = 8
		hotbar.select(8)
		
	if Input.is_action_just_released("scroll_down"):
		selected_item_index += 1
		hotbar.select(selected_item_index)
		
	if Input.is_action_just_released("scroll_up"):
		selected_item_index -= 1
		hotbar.select(selected_item_index)
	
	
	
	if is_on_floor():
		velocity.x = Input.get_axis("a_click" , "d_click") * speed
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jumpforce
	
	velocity.y += gravity
	
	get_out.global_position = global_position + (get_global_mouse_position() - global_position).normalized() * 50
	gun.global_position = global_position + (get_global_mouse_position() - global_position).normalized() * 50
	velocity += shot_power / (global_position.distance_to(shot_position)) * (global_position - shot_position).normalized()
	shot_power = 0
	shot_position = Vector2.ZERO
	
	
	velocity = move_and_slide(velocity , Vector2.UP)
	
	
	
	if hotbar.get_item_text(selected_item_index) == "gun":
		gun.selected = true
	else:
		gun.selected = false
	if hotbar.get_item_text(selected_item_index) == "get_out":
		get_out.selected = true
	else:
		get_out.selected = false
	if hotbar.get_item_text(selected_item_index) == "dog" and not dog_selected:
		dog_selected = true
		speed *= 5
		jumpforce *= 1.5
	elif dog_selected and not hotbar.get_item_text(selected_item_index) == "dog":
		dog_selected = false
		speed /= 5
		jumpforce /=1.5



func _on_hotbar_item_selected(index):
	if not hotbar.get_item_icon(index) == null and first_item_selected == false:
		is_dragging_item = true
		first_item_selected = true
		first_item_selected_info = [index , hotbar.get_item_text(index) , hotbar.get_item_icon(index)]
		
	elif not first_item_selected == false:
		hotbar.set_item_text(first_item_selected_info[0] , hotbar.get_item_text(index))
		hotbar.set_item_icon(first_item_selected_info[0] , hotbar.get_item_icon(index))
		hotbar.set_item_text(index , first_item_selected_info[1])
		hotbar.set_item_icon(index , first_item_selected_info[2])
		first_item_selected = false
		
	hotbar.select(selected_item_index)



