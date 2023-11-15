extends Control


func _physics_process(delta):
	Global.volume = $HScrollBar.value
	print(Global.volume)



func _on_Button_button_down():
	get_tree().change_scene("res://main_screen.tscn")
