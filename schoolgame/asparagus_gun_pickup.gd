extends Area2D


onready var player = get_parent().get_node("Player")
var asparagus_gun_texture = preload("res://icon.png")
var hotbar_number_checking = 1
var player_lowest_non_selected : int
var player_lowest_non_selected_found = false
var item_picked_up = false
var enabled = true

func _physics_process(delta):
	
	if enabled:
		if get_overlapping_bodies():
			$Press_E.show()
			$Press_E.global_position = player.global_position + Vector2(7 , -40)
			if Input.is_action_just_pressed("interact"):
				item_picked_up = true
				$Press_E.hide()
				Global.asparagus_gun_picked_up = true
				get_parent().get_node("asparagus_gun_pickup_sprite").hide()
				while not player_lowest_non_selected_found:
					if player.get_node("CanvasLayer/Hotbar").get_item_icon(hotbar_number_checking-1) == null:
						player_lowest_non_selected_found = true
					else:
						hotbar_number_checking += 1
				player.get_node("CanvasLayer/Hotbar").set_item_icon(hotbar_number_checking - 1 , asparagus_gun_texture)
				player.get_node("CanvasLayer/Hotbar").set_item_text(hotbar_number_checking - 1 , "asparagus_gun")
				queue_free()
		else:
			$Press_E.hide()
	else:
		$Press_E.hide()

