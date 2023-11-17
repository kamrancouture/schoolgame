extends Node2D





	



	
	


func _on_Button_button_down():
	get_tree().change_scene("res://high_tech_hop.tscn")
	Global.numbers_of_death_high_hop = -100
