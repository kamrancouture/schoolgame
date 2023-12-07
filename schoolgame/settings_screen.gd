extends Control
func _ready():
	$HScrollBar.value = Global.volume
	$settings_music.play()
func _physics_process(delta):
	Global.volume = $HScrollBar.value
	$Label.text = String(int((Global.volume + 65) / 65 * 100)) + "%"








func _on_back_to_main_screen_button_button_down():
	get_tree().change_scene("res://main_screen.tscn")


func _on_Timer_timeout():
	$difficulty.pressed = false


func _on_difficulty_pressed():
	$Timer.start()
	if Global.difficulty == "normal":
		$difficulty/difficulty.text = "insane"
		$difficulty/difficulty.set("custom_colors/font_color" , Color(255,0,0))
		Global.difficulty = "insane"
	elif Global.difficulty == "insane":
		$difficulty/difficulty.text = "normal"
		$difficulty/difficulty.set("custom_colors/font_color" , Color(0,255,0))
		Global.difficulty = "normal"
		
