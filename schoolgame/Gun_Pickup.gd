extends Area2D

var gun_texture = preload("res://Assets/gun_icon_fixed_fixed.png")
var hotbar_number_checking = 1
var player_lowest_non_selected : int
var player_lowest_non_selected_found = false
var item_picked_up = false

onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	
	
	if get_overlapping_bodies() and not item_picked_up:
		$Press_E.show()
		$Press_E.global_position = player.global_position + Vector2(7 , -40)
		if Input.is_action_just_pressed("interact"):
			Global.XP += 10
			item_picked_up = true
			$Press_E.hide()
			Global.gun_picked_up = true
			get_parent().get_node("gun_pickup_sprites").hide()
			while not player_lowest_non_selected_found:
				if player.get_node("CanvasLayer/Hotbar").get_item_icon(hotbar_number_checking-1) == null:
					player_lowest_non_selected_found = true
				else:
					hotbar_number_checking += 1
			player.get_node("CanvasLayer/Hotbar").set_item_icon(hotbar_number_checking - 1 , gun_texture)
			player.get_node("CanvasLayer/Hotbar").set_item_text(hotbar_number_checking - 1 , "duck_hunt_gun")
	else:
		$Press_E.hide()
