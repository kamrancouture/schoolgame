extends Node2D


func _physics_process(delta):
	if Global.duck_hunt_defeated:
		$DuckHuntLeaderboardStarter.hide()
		$DuckHuntLeaderboardPlayerScore.show()
		$DuckHuntLeaderboardPlayerScore/record.text = String(Global.duck_hunt_highscore)
	else:
		$DuckHuntLeaderboardPlayerScore.hide()
		$DuckHuntLeaderboardStarter.show()


func _on_exit_button_down():
	get_tree().change_scene("res://starting_room.tscn")
