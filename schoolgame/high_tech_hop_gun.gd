extends Node2D

var selected = false
var shotpower = 1000
var can_shoot = true
var max_ammo = 3
var ammo = 0

func _physics_process(delta):
	
	if get_parent().is_on_floor():
		ammo = max_ammo
	
	
	if selected:
		show()
		
		
		get_parent().get_node("CanvasLayer/ammo").text = "Ammo: " + String(ammo) 
		
		global_rotation = (get_global_mouse_position() - get_parent().global_position).angle()
		
		
		if Input.is_action_pressed("shoot") and can_shoot and ammo > 0:
			$gunshot.play()
			ammo -= 1
			can_shoot = false
			get_parent().shot_direction = (global_position - $high_tech_hop_gun/Position2D.global_position).normalized()
			get_parent().shot_power = shotpower
			$fire_rate.start()
	else:
		hide()



func _on_fire_rate_timeout():
	can_shoot = true
