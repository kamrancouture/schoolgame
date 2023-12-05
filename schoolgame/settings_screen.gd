extends Control
func _ready():
	$HScrollBar.value = Global.volume
	$settings_music.play()
func _physics_process(delta):
	Global.volume = $HScrollBar.value
	$Label.text = String(int((Global.volume + 65) / 65 * 100)) + "%"








func _on_back_to_main_screen_button_button_down():
	get_tree().change_scene("res://main_screen.tscn")

func _on_difficulty_button_down():
	print("ih")
	if Global.difficulty == "normal":
		$difficulty.text = "insane"
		$difficulty.add_color_override("font_color" , Color(255,0,0))
		Global.difficulty = "insane"
	elif Global.difficulty == "insane":
		$difficulty.text = "normal"
		$difficulty.add_color_override("font_color" , Color(8,198,113))
		Global.difficulty = "normal"
		
