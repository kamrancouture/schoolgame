extends Control


func _ready():
	$menu_music.play()

func _on_play_button_button_down():
	Global.restart()
	get_tree().change_scene("res://starting_room.tscn")


func _on_settings_button_button_down():
	get_tree().change_scene("res://settings_screen.tscn")


func _on_credits_button_down():
	get_tree().change_scene("res://credits_screen.tscn")
