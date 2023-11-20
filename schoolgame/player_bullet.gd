extends Area2D

var speed = 15
var damage = 1

func _physics_process(delta):
	global_position += Vector2(speed , 0).rotated(rotation)


func _on_player_bullet_body_entered(body):
	if "health" in body:
		body.hit()
		body.health -= 1
		set_physics_process(false)
		hide()
		$hit_enemy.play()
		yield($hit_enemy , "finished")
	queue_free()
