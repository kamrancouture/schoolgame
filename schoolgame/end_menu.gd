extends Control





func _on_Button_pressed():
	Global.restart()
	get_tree().change_scene("res://main_screen.tscn")
