extends Node2D

onready var player = get_node("high_tech_hop_player")

func _physics_process(delta):
	if Global.numbers_of_death_high_hop == 10:
		get_tree().change_scene("res://high_tech_hop_you_suck_menu.tscn")
	


func _on_Area2D_body_entered(body):
	Global.numbers_of_death_high_hop += 1
	Global.player_hotbar = player.hotbar.items
	get_tree().change_scene("res://high_tech_hop.tscn")
	
