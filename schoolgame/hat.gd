extends Area2D



onready var player = get_parent().get_node("high_tech_hop_player")
var hat_texture = preload("res://Assets/high_hop_hat_icon.png")
var hotbar_number_checking = 1
var player_lowest_non_selected : int
var player_lowest_non_selected_found = false
var item_picked_up = false

func _physics_process(delta):
	
	if get_overlapping_bodies():
		$Press_E.show()
		$Press_E.global_position = player.global_position + Vector2(10 , -55)
		if Input.is_action_just_pressed("interact"):
			$Press_E.hide()
			Global.XP += 30
			item_picked_up = true
			Global.hat_picked_up = true
			get_parent().get_node("hat_pickup").hide()
			while not player_lowest_non_selected_found:
				if player.get_node("CanvasLayer/Hotbar").get_item_icon(hotbar_number_checking-1) == null:
					player_lowest_non_selected_found = true
				else:
					hotbar_number_checking += 1
			player.get_node("CanvasLayer/Hotbar").set_item_icon(hotbar_number_checking - 1 , hat_texture)
			player.get_node("CanvasLayer/Hotbar").set_item_text(hotbar_number_checking - 1 , "hat")
			Global.player_hotbar = player.hotbar.items
			Global.world = "asparagus_world"
			get_tree().change_scene("res://asparagus_world.tscn")
	else:
		$Press_E.hide()
