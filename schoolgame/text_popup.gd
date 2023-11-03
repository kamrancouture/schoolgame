extends PanelContainer


func _ready():
	add_to_group("text_popups")

func pop_up():
	show()
	$AnimationPlayer.play("RESET")
	$time_showing.start()
	remove_from_group("text_popups")
	get_tree().call_group("text_popups" , "end_early")
	add_to_group("text_popups")
	show()

func _on_time_showing_timeout():
	$AnimationPlayer.play("fade")


func end_early():
	hide()
