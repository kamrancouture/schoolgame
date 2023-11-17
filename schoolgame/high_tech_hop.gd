extends Node2D

func _physics_process(delta):
	if Global.numbers_of_death_high_hop == 10:
		get_tree().change_scene("res://high_tec_hop_you_suck_manu.tscn")
	


func _on_Area2D_body_entered(body):
	Global.numbers_of_death_high_hop += 1
	get_tree().change_scene("res://high_tech_hop.tscn")
	
