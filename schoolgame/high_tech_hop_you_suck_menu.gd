extends Node2D





	



	
	


func _on_Button_button_down():
	get_tree().change_scene("res://main_screen.tscn")
	Global.numbers_of_death_high_hop = 0
