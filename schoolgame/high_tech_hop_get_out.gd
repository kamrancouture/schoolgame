extends Node2D

var Grenade = preload("res://high_tech_hop_grenade.tscn")
var selected = false
var can_shoot = true
var max_ammo = 1
var ammo = 0

func _physics_process(delta):
	
	if selected:
		show()
		get_parent().get_node("CanvasLayer/ammo").text = "Ammo: " + String(ammo) 
		
		global_rotation = (get_global_mouse_position() - get_parent().global_position).angle()
		
		if get_parent().is_on_floor():
			ammo = max_ammo
		
		if Input.is_action_pressed("shoot") and can_shoot and ammo > 0:
			ammo -= 1
			can_shoot = false 
			var grenade = Grenade.instance()
			grenade.global_position = $high_tech_hop_get_out/grenade_spawn.global_position
			get_parent().get_parent().add_child(grenade)
			$high_tech_hop_get_out/fire_rate.start()
	else:
		hide()



func _on_fire_rate_timeout():
	can_shoot = true




