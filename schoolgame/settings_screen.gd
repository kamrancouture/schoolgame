extends Control

func _ready():
	$HScrollBar.value = Global.volume
	$settings_music.play()
func _physics_process(delta):
	Global.volume = $HScrollBar.value
	$Label.text = String(int((Global.volume + 65) / 65 * 100)) + "%"



func _on_Button_button_down():
	get_tree().change_scene("res://main_screen.tscn")


