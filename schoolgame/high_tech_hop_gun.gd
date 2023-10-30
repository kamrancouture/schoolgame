extends Sprite

var shotpower = 1000
var can_shoot = true
var max_ammo = 3
var ammo = 0

func _physics_process(delta):
	
	get_parent().get_node("CanvasLayer/ammo").text = "Ammo: " + String(ammo) 
	
	global_rotation = (get_global_mouse_position() - get_parent().global_position).angle()
	
	if get_parent().is_on_floor():
		ammo = max_ammo
	
	if Input.is_action_pressed("shoot") and can_shoot and ammo > 0:
		ammo -= 1
		can_shoot = false
		get_parent().shot_power = shotpower
		get_parent().shot_position = $Position2D.global_position
		$fire_rate.start()
	



func _on_fire_rate_timeout():
	can_shoot = true
