extends Node2D

onready var player = get_node("high_tech_hop_player")

func _ready():
	if not Global.visited_high_hop:
		Global.visited_high_hop = true
		player.get_node("CanvasLayer/new_world_animation/world_label").text = "high tech hop"
		player.get_node("CanvasLayer/new_world_animation/AnimationPlayer").play("fade_out_label")

func _physics_process(delta):
	if Global.numbers_of_death_high_hop == 10:
		get_tree().change_scene("res://high_tech_hop_you_suck_menu.tscn")
	


func _on_Area2D_body_entered(body):
	Global.numbers_of_death_high_hop += 1
	Global.player_hotbar = player.hotbar.items
	Global.world = "computer_class"
	get_tree().change_scene("res://high_tech_hop.tscn")
	
