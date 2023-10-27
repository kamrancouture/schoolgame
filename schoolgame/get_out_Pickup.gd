extends Area2D

onready var player = get_parent().get_node("Player")
var get_out_texture = preload("res://Assets/get_out_icon_proper_size2.png")
var hotbar_number_checking = 1
var player_lowest_non_selected : int
var player_lowest_non_selected_found = false
var item_picked_up = false

func _physics_process(delta):
	
	if get_overlapping_bodies():
		$Press_E.show()
		$Press_E.global_position = player.global_position + Vector2(7 , -40)
		if Input.is_action_just_pressed("interact"):
			Global.XP += 50
			item_picked_up = true
			$Press_E.hide()
			Global.get_out_picked_up = true
			get_parent().get_node("get_out_pickup_sprite").hide()
			while not player_lowest_non_selected_found:
				if player.get_node("CanvasLayer/Hotbar").get_item_icon(hotbar_number_checking-1) == null:
					player_lowest_non_selected_found = true
				else:
					hotbar_number_checking += 1
			player.get_node("CanvasLayer/Hotbar").set_item_icon(hotbar_number_checking - 1 , get_out_texture)
			player.get_node("CanvasLayer/Hotbar").set_item_text(hotbar_number_checking - 1 , "get_out")
			queue_free()
	else:
		$Press_E.hide()
