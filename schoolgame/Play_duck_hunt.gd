extends Area2D

onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	
	if get_overlapping_bodies():
		$Press_E.show()
		$Press_E.global_position = player.global_position + Vector2(7 , -40)
		if Input.is_action_just_pressed("interact") and Global.gun_picked_up:
			get_tree().change_scene("res://duck_hunt.tscn")
		elif Input.is_action_just_pressed("interact"):
			get_parent().get_node("CanvasLayer/text_popups/cant_play_duck_hunt").pop_up()
	else:
		$Press_E.hide()
