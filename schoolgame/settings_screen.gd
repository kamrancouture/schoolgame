extends Control

func _ready():
	$HScrollBar.value = Global.volume
func _physics_process(delta):
	Global.volume = $HScrollBar.value




func _on_Button_button_down():
	get_tree().change_scene("res://main_screen.tscn")
