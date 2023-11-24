extends Area2D

var paper_sprite_1 = preload("res://Assets/paper_images/asparagus_paper_1.png")
var paper_sprite_2 = preload("res://Assets/paper_images/asparagus_paper_2.png")
var paper_sprite_3 = preload("res://Assets/paper_images/asparagus_paper_3.png")
var paper_sprite_4 = preload("res://Assets/paper_images/asparagus_paper_4.png")
var paper_sprite_5 = preload("res://Assets/paper_images/asparagus_paper_5.png")
signal paper_collected

onready var player = get_parent().get_parent().get_node("Player")
var get_out_texture = preload("res://icon.png")
var hotbar_number_checking = 1
var player_lowest_non_selected : int
var player_lowest_non_selected_found = false
var item_picked_up = false
func _physics_process(delta):
	if get_overlapping_bodies():
		$Press_E.show()
		$Press_E.global_position = player.global_position + Vector2(7 , -40)
		if Input.is_action_just_pressed("interact"):
			emit_signal("paper_collected")
			Global.XP += 20
			Global.paper_number += 1
			if Global.paper_number == 1:
				$asparagus_image.texture = paper_sprite_1
			elif Global.paper_number == 2:
				$asparagus_image.texture = paper_sprite_2
			$Press_E.hide()
			set_physics_process(false)
	else:
		$Press_E.hide()
