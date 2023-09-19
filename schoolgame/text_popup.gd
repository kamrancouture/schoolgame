extends PanelContainer


func pop_up():
	$AnimationPlayer.play("RESET")
	$time_showing.start()
	show()

func _on_time_showing_timeout():
	$AnimationPlayer.play("fade")
