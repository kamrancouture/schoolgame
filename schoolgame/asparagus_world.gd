extends Node2D


func _physics_process(delta):
	$CanvasLayer/Label.text = "papers: " + String(Global.paper_number) + "/5"
	if Global.paper_number == 5:
		get_tree().change_scene("res://aspara-gus_world.tscn")
