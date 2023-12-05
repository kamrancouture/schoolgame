extends Control
func _ready():
	$HScrollBar.value = Global.volume
	$settings_music.play()
func _physics_process(delta):
	Global.volume = $HScrollBar.value
	$Label.text = String(int((Global.volume + 65) / 65 * 100)) + "%"








func _on_back_to_main_screen_button_button_down():
	get_tree().change_scene("res://main_screen.tscn")

func _on_insane_mode_button_down():
	if not Global.player_is_in_insane_mode:
		Global.player_is_in_insane_mode = true
	if Global.player_is_in_insane_mode:
		Global.player_is_in_insane_mode = false
		
