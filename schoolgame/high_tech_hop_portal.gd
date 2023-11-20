extends Area2D


onready var player = get_parent().get_node("Player")
var get_out_texture = preload("res://icon.png")
var hotbar_number_checking = 1
var player_lowest_non_selected : int
var player_lowest_non_selected_found = false
var item_picked_up = false
var enabled = false

func _physics_process(delta):
	if enabled:
		if get_overlapping_bodies():
			$Press_E.show()
			$Press_E.global_position = player.global_position + Vector2(7 , -40)
			if Input.is_action_just_pressed("interact"):
				get_tree().change_scene("res://high_tech_hop.tscn")
	else:
		$Press_E.hide()

