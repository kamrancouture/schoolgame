extends PanelContainer


func pop_up():
	if not $AnimationPlayer.is_playing():
		$time_showing.start()
		show()

func _on_time_showing_timeout():
	$AnimationPlayer.play("fade")
