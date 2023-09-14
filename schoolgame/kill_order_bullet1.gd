extends Area2D
var speed = 10
var damage = 1

func _physics_process(delta):
	global_position += Vector2(speed , 0).rotated(rotation)


func _on_Area2D_body_entered(body):
	if "health" in body:
		body.health -= damage
		body.hit()
	queue_free()
