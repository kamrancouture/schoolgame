extends Node2D


onready var player = get_node("Player")

func _ready():
	player.hat_equips = 2
	player.get_node("CanvasLayer/new_world_animation/world_label").text = "Mr.C's backyard garden"
	player.get_node("CanvasLayer/new_world_animation/AnimationPlayer").play("fade_out_label")
	
	$aspara_gus_teleporter.hide()

func _physics_process(delta):
	$CanvasLayer/Label.text = "papers: " + String(Global.paper_number) + "/5"
	if Global.paper_number == 5:
		$aspara_gus_teleporter.show()
