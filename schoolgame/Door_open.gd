extends Area2D



onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	
	if get_overlapping_bodies():
		$Press_E.show()
		$Press_E.global_position = player.global_position + Vector2(7 , -40)
		if Input.is_action_just_pressed("interact") and Global.gun_picked_up:
			get_tree().change_scene("res://world.tscn")
	else:
		$Press_E.hide()

