extends Node2D

func _ready():
	$aspara_gus_teleporter.hide()
func _physics_process(delta):
	$CanvasLayer/Label.text = "papers: " + String(Global.paper_number) + "/5"
	if Global.paper_number == 5:
		$aspara_gus_teleporter.show()
