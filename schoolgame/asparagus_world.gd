extends Node2D


func _physics_process(delta):
	$CanvasLayer/Label.text = "papers: " + String(Global.paper_number) + "/5"
	
