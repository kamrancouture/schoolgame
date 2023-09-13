extends Area2D

var item_picked_up = false
onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	
	if get_overlapping_bodies() and not item_picked_up:
		$Press_E.show()
		$Press_E.global_position = player.global_position + Vector2(7 , -40)
		if Input.is_action_just_pressed("pickup_item"):
			item_picked_up = true
			$Press_E.hide()
			player.gun_picked_up = true
			get_parent().get_node("gun_pickup_sprites").hide()
	else:
		$Press_E.hide()
