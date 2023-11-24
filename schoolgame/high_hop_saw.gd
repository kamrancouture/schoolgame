extends Area2D

onready var player = get_parent().get_parent().get_node("high_tech_hop_player")






func _on_high_hop_saw_body_entered(body):
	Global.numbers_of_death_high_hop += 1
	Global.player_hotbar = player.hotbar.items
	get_tree().change_scene("res://high_tech_hop.tscn")
