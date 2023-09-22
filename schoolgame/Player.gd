extends KinematicBody2D

var first_item_selected_slot = null
var hotbar_slot_dragging : int
var is_dragging_item = false
var item_dragging_icon = null
var Death_Effect = preload("res://player_death.tscn")
var Blood_Effect = preload("res://player_blood_effect.tscn")
var reloading = false
var ammo = 30
var max_ammo = 30
export var fire_rate = 0.2
var Player_Bullet = preload("res://player_bullet.tscn")
var can_shoot = true
var gun_in_hand = false
var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()
export var max_health = 30
export var health = 30
var selected_item_index : int

func _ready():
	$CanvasLayer/Hotbar.select(0)
	$health_bar.max_value = max_health
	$AnimatedSprite.play("idle")

func _physics_process(delta):
	
	if Global.player_alive:
		if Input.is_action_just_pressed("hotbar_1"):
			selected_item_index = 0
			$CanvasLayer/Hotbar.select(0)
		elif Input.is_action_just_pressed("hotbar_2"):
			selected_item_index = 1
			$CanvasLayer/Hotbar.select(1)
		elif Input.is_action_just_pressed("hotbar_3"):
			selected_item_index = 2
			$CanvasLayer/Hotbar.select(2)
		elif Input.is_action_just_pressed("hotbar_4"):
			selected_item_index = 3
			$CanvasLayer/Hotbar.select(3)
		elif Input.is_action_just_pressed("hotbar_5"):
			selected_item_index = 4
			$CanvasLayer/Hotbar.select(4)
		elif Input.is_action_just_pressed("hotbar_6"):
			selected_item_index = 5
			$CanvasLayer/Hotbar.select(5)
		elif Input.is_action_just_pressed("hotbar_7"):
			selected_item_index = 6
			$CanvasLayer/Hotbar.select(6)
		elif Input.is_action_just_pressed("hotbar_8"):
			selected_item_index = 7
			$CanvasLayer/Hotbar.select(7)
		elif Input.is_action_just_pressed("hotbar_9"):
			selected_item_index = 8
			$CanvasLayer/Hotbar.select(8)
		
		
		if Global.gun_picked_up and gun_in_hand:
			$CanvasLayer/Ammo.show()
		else:
			$CanvasLayer/Ammo.hide()
		
		$health_bar.value = health
		
		if health <= 0 and Global.player_alive:
			$health_bar.hide()
			Global.player_alive = false
			hide()
			var death_effect = Death_Effect.instance()
			death_effect.global_position = global_position
			death_effect.emitting = true
			get_parent().add_child(death_effect)
		
		$CanvasLayer/Ammo.text = "Ammo: " + String(ammo) + "/" + String(max_ammo)
		velocity = Input.get_vector("a_click" , "d_click" , "w_click" , "s_click") * Global.player_speed
		
		velocity = move_and_slide(velocity)
		$AnimatedSprite.look_at(get_global_mouse_position())
		
		$health_bar.rect_rotation = -rotation
		
		$health_bar.set_rotation(0)
		
		if not velocity == Vector2.ZERO and not gun_in_hand:
			$walking.pitch_scale = 1.5
			$walking.stream_paused = false
		elif not velocity == Vector2.ZERO:
			$walking.pitch_scale = 1
			$walking.stream_paused = false
		else:
			$walking.stream_paused = true
		
		if $CanvasLayer/Hotbar.get_item_text(selected_item_index) == "gun" and not gun_in_hand and Global.gun_picked_up:
			gun_in_hand = true
			Global.player_speed /= 1.5
			$AnimatedSprite.play("pistol")
		elif not $CanvasLayer/Hotbar.get_item_text(selected_item_index) == "gun" and gun_in_hand:
			gun_in_hand = false
			Global.player_speed *= 1.5
			$AnimatedSprite.play("idle")
		
		if Input.is_action_just_pressed("reload") and not reloading and not ammo == max_ammo and gun_in_hand:
			reload()
		
		if Input.is_action_pressed("shoot") and can_shoot and gun_in_hand and ammo > 0 and not reloading:
			shoot()
		
		elif ammo == 0 and gun_in_hand and not reloading:
			reload()


func hit():
	var blood_effect = Blood_Effect.instance()
	blood_effect.global_position = global_position
	blood_effect.emitting = true
	get_parent().add_child(blood_effect)
	$hit.play()


func shoot():
	ammo -= 1
	can_shoot = false
	var player_bullet = Player_Bullet.instance()
	player_bullet.global_position = $AnimatedSprite/bullet_spawn.global_position
	player_bullet.global_rotation = $AnimatedSprite.global_rotation
	get_parent().add_child(player_bullet)
	$gunshot.play()
	$fire_rate.start(fire_rate)

func reload():
	reloading = true
	$reload.play()
	$AnimatedSprite.play("reload")
	yield($AnimatedSprite , "animation_finished")
	reloading = false
	$AnimatedSprite.play("pistol")
	ammo = max_ammo

func _on_fire_rate_timeout():
	can_shoot = true






func _on_Hotbar_item_selected(index):
	if not $CanvasLayer/Hotbar.get_item_icon(index) == null and first_item_selected_slot == null:
		is_dragging_item = true
		first_item_selected_slot = index
		
	elif not first_item_selected_slot == null:
		$CanvasLayer/Hotbar.move_item(first_item_selected_slot , index)
		first_item_selected_slot = null
		
	$CanvasLayer/Hotbar.select(selected_item_index)


