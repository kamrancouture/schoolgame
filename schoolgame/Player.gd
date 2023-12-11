extends KinematicBody2D

signal paper_collected

var first_item_selected = false
var first_item_selected_info = [
	null,
	"item",
	null,
]
var paper_on_screen = false
var asparagus_image = null
var paper = null
var paper_moving = false
var Grenade = preload("res://grenade.tscn")
onready var hotbar = $CanvasLayer/Hotbar
var is_dragging_item = false
var Death_Effect = preload("res://player_death.tscn")
var Blood_Effect = preload("res://player_blood_effect.tscn")
var reloading = false
var hat_equips = 3
var rocket_launcher_ammo = 1
var ammo = 30
var max_ammo = 30
export var fire_rate = 0.2
var Player_Bullet = preload("res://player_bullet.tscn")
var can_shoot = true
var riding_dog = false
var dog_was_in_op_mode = false
var can_shoot_grenade = true
var get_out_in_hand = false
var grenade_speed = 100
var asparagus_gun_in_hand = false
var dog_in_hand = false
var gun_in_hand = false
var hat_in_hand = false
var wearing_hat = false
var can_wear_hat = true
var is_in_asparagus = false
var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()
export var max_health = 30
export var health = 30
var selected_item_index : int

func _ready():
	if Global.difficulty and not Global.world == "starting_room":
		health = Global.player_health_for_insane_mode
	if Global.world == "starting_room":
		get_parent().player = self
		Global.player_speed = 225
	elif Global.world == "computer_class":
		Global.player_speed = 300
	elif Global.world == "asparagus_world":
		Global.player_speed = 375
	elif Global.world == "aspara_gus_world":
		Global.player_speed = 375
	elif Global.world == "mike_hunt_world":
		Global.player_speed = 400
	if not Global.player_hotbar == null:
		hotbar.items = Global.player_hotbar
	
	if not Global.player_previous_position == null and Global.player_previous_world == Global.world:
		global_position = Global.player_previous_position
	
	hotbar.select(0)
	selected_item_index = 0
	$health_bar.max_value = max_health
	$AnimatedSprite.play("idle")
	
	if not Global.player_hotbar == null:
		hotbar.items = Global.player_hotbar
	elif not Global.world == "starting_room":
		hotbar.items = Global.player_items_cheat



func _physics_process(delta):
	if Global.difficulty:
		Global.player_health_for_insane_mode = health
	
	if paper_moving:
		move_paper_animation(paper , asparagus_image)
	elif paper_on_screen and Input.is_action_just_pressed("shoot"):
		paper_on_screen = false
		Global.paper_pause = false
		paper.get_parent().queue_free()
	
	if not Global.paper_pause:
		if $Area2D.overlaps_body(get_parent().get_node("asparagus_walls")):
			health -= 0.025
		if $Area2D.overlaps_body(get_parent().get_node("asparagus_walls")) and not is_in_asparagus:
			is_in_asparagus = true
			Global.player_speed /=  5
		elif not $Area2D.overlaps_body(get_parent().get_node("asparagus_walls")) and is_in_asparagus:
			is_in_asparagus = false
			Global.player_speed *= 5
		
		$CanvasLayer/XP_bar.value = Global.XP
		
		Global.player_previous_world = Global.world
		Global.player_previous_position = global_position
		
		if Global.player_alive:
			if Input.is_action_just_pressed("hotbar_1"):
				selected_item_index = 0
				hotbar.select(0)
			elif Input.is_action_just_pressed("hotbar_2"):
				selected_item_index = 1
				hotbar.select(1)
			elif Input.is_action_just_pressed("hotbar_3"):
				selected_item_index = 2
				hotbar.select(2)
			elif Input.is_action_just_pressed("hotbar_4"):
				selected_item_index = 3
				hotbar.select(3)
			elif Input.is_action_just_pressed("hotbar_5"):
				selected_item_index = 4
				hotbar.select(4)
			elif Input.is_action_just_pressed("hotbar_6"):
				selected_item_index = 5
				hotbar.select(5)
			elif Input.is_action_just_pressed("hotbar_7"):
				selected_item_index = 6
				hotbar.select(6)
			elif Input.is_action_just_pressed("hotbar_8"):
				selected_item_index = 7
				hotbar.select(7)
			elif Input.is_action_just_pressed("hotbar_9"):
				selected_item_index = 8
				hotbar.select(8)
			
			if Input.is_action_just_released("scroll_down") and selected_item_index < 8:
				selected_item_index += 1
				hotbar.select(selected_item_index)
			
			if Input.is_action_just_released("scroll_up") and selected_item_index > 0:
				selected_item_index -= 1
				hotbar.select(selected_item_index)
			
			Global.player_hotbar = hotbar.items
			
			$health_bar.value = health
			
			if health <= 0 and Global.player_alive:
				$health_bar.hide()
				Global.player_alive = false
				hide()
				$you_lose_timer.start()
				var death_effect = Death_Effect.instance()
				death_effect.global_position = global_position
				death_effect.emitting = true
				get_parent().add_child(death_effect)
			
			$CanvasLayer/get_out_ammo_reload.text = String((round ($get_out_fire_rate.time_left*pow (10,2))/pow (10,2)))
			$CanvasLayer/hat_ammo.text = "equips left: " + String(hat_equips)
			$CanvasLayer/Ammo.text = "Ammo: " + String(ammo)
			velocity = Input.get_vector("a_click" , "d_click" , "w_click" , "s_click") * Global.player_speed
			
			velocity = move_and_slide(velocity)
			$AnimatedSprite.look_at(get_global_mouse_position())
			
			if not velocity == Vector2.ZERO:
				if dog_in_hand:
					$dog_running.stream_paused = false
					$walking.stream_paused = true
					$walking_gun.stream_paused = true
				elif gun_in_hand:
					$dog_running.stream_paused = true
					$walking.stream_paused = true
					$walking_gun.stream_paused = false
				else:
					$dog_running.stream_paused = true
					$walking_gun.stream_paused = true
					$walking.stream_paused = false
			else:
				$dog_running.stream_paused = true
				$walking_gun.stream_paused = true
				$walking.stream_paused = true
			
			if hotbar.get_item_text(selected_item_index) == "get_out" and not get_out_in_hand:
				if Global.OP_mode:
					$get_out_fire_rate.stop()
				if $get_out_fire_rate.time_left == 0:
					$CanvasLayer/get_out_ammo.show()
				else:
					$CanvasLayer/get_out_ammo_reload.show()
				get_out_in_hand = true
				Global.player_speed /= 1.5
				$AnimatedSprite.play("hold")
				$AnimatedSprite/get_out_sprite.show()
			elif not hotbar.get_item_text(selected_item_index) == "get_out" and get_out_in_hand:
				$CanvasLayer/get_out_ammo_reload.hide()
				$CanvasLayer/get_out_ammo.hide()
				$AnimatedSprite/get_out_sprite.hide()
				get_out_in_hand = false
				Global.player_speed *= 1.5
				
			if hotbar.get_item_text(selected_item_index) == "gun" and not gun_in_hand:
				$CanvasLayer/Ammo.show()
				gun_in_hand = true
				Global.player_speed /= 1.5
				$AnimatedSprite.play("pistol")
			elif not hotbar.get_item_text(selected_item_index) == "gun" and gun_in_hand:
				$CanvasLayer/Ammo.hide()
				gun_in_hand = false
				Global.player_speed *= 1.5
				
			if hotbar.get_item_text(selected_item_index) == "asparagus_gun" and not asparagus_gun_in_hand:
				if Global.OP_mode:
					$AnimatedSprite/asparagus_gun/Area2D/CollisionShape2D.scale *= 100
				else:
					$AnimatedSprite/asparagus_gun/Area2D/CollisionShape2D.scale = Vector2.ONE
				asparagus_gun_in_hand = true
				Global.player_speed /= 1.5
				$AnimatedSprite/asparagus_gun/Area2D/CollisionShape2D.disabled = false
				$AnimatedSprite.play("hold")
				$AnimatedSprite/asparagus_gun.show()
			elif not hotbar.get_item_text(selected_item_index) == "asparagus_gun" and asparagus_gun_in_hand:
				asparagus_gun_in_hand = false
				Global.player_speed *= 1.5
				$AnimatedSprite/asparagus_gun/Area2D/CollisionShape2D.disabled = true
				$AnimatedSprite/asparagus_gun.hide()
				
			if hotbar.get_item_text(selected_item_index) == "hat" and not hat_in_hand:
				hat_in_hand = true
				$CanvasLayer/hat_ammo.show()
				if not Global.OP_mode:
					$AnimatedSprite/hat_holding.show()
					$AnimatedSprite.play("hold")
				else:
					$AnimatedSprite.play("idle")
			elif not hotbar.get_item_text(selected_item_index) == "hat" and hat_in_hand:
				$CanvasLayer/hat_ammo.hide()
				$AnimatedSprite/hat_holding.hide()
				hat_in_hand = false
				
			if hotbar.get_item_icon(selected_item_index) == null:
				$AnimatedSprite.play("idle")
			
			if Input.is_action_just_pressed("reload") and not reloading and not ammo == max_ammo and gun_in_hand:
				reload()
			
			if Input.is_action_pressed("shoot"):
				if can_shoot and gun_in_hand and ammo > 0 and not reloading:
					shoot()
				elif get_out_in_hand and can_shoot_grenade:
					if not Global.OP_mode:
						can_shoot_grenade = false
						$get_out_fire_rate.start()
					shoot_grenade()
				elif hat_in_hand and can_wear_hat and hat_equips > 0:
					hat_equips -= 1
					can_wear_hat = false
					Global.player_speed *= 1.25
					can_shoot_grenade = true
					$AnimatedSprite/hat_holding.hide()
					$AnimatedSprite/hat_wearing.show()
					$AnimatedSprite.play("idle")
					Global.OP_mode = true
					$OP_time.start()
					
			if $CanvasLayer/Hotbar.get_item_text(selected_item_index) == "dog" and not dog_in_hand:
				$AnimatedSprite. play("idle")
				$AnimatedSprite/dog.show()
				dog_in_hand = true
				if Global.OP_mode:
					dog_was_in_op_mode = true
					Global.player_speed *= 2
				Global.player_speed *= 2
				
			elif dog_in_hand and not $CanvasLayer/Hotbar.get_item_text(selected_item_index) == "dog":
				dog_in_hand = false
				$AnimationPlayer.play("idle")
				$AnimatedSprite/dog.hide()
				if dog_was_in_op_mode:
					dog_was_in_op_mode = false
					Global.player_speed /= 2
				Global.player_speed /= 2
			if velocity == Vector2.ZERO and dog_in_hand:
				$AnimationPlayer.play("idle")
			elif dog_in_hand:
				$AnimationPlayer.play("dog_running")
			

			
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
	if Global.OP_mode:
		$fire_rate.start(fire_rate / 4)
	else:
		$fire_rate.start(fire_rate)

func shoot_grenade():
	if not Global.OP_mode:
		$CanvasLayer/get_out_ammo.hide()
		$CanvasLayer/get_out_ammo_reload.show()
	var grenade = Grenade.instance()
	grenade.global_rotation = $AnimatedSprite.global_rotation
	grenade.global_position = $AnimatedSprite/get_out_sprite/get_out_grenade_spawn.global_position
	get_parent().add_child(grenade)

func reload():
	reloading = true
	$reload.play()
	$AnimatedSprite.play("reload")
	yield($AnimatedSprite , "animation_finished")
	reloading = false
	if $CanvasLayer/Hotbar.get_item_text(selected_item_index) == "gun":
		$AnimatedSprite.play("pistol")
		ammo = max_ammo


func _on_fire_rate_timeout():
	can_shoot = true

func throw_grenade():
	var grenade = Grenade.instance()
	$AnimatedSprite.play("hold")
	
	




func _on_Hotbar_item_selected(index):
	if not hotbar.get_item_icon(index) == null and first_item_selected == false:
		is_dragging_item = true
		first_item_selected = true
		first_item_selected_info = [index , hotbar.get_item_text(index) , hotbar.get_item_icon(index)]
		
	elif not first_item_selected == false:
		hotbar.set_item_text(first_item_selected_info[0] , hotbar.get_item_text(index))
		hotbar.set_item_icon(first_item_selected_info[0] , hotbar.get_item_icon(index))
		hotbar.set_item_text(index , first_item_selected_info[1])
		hotbar.set_item_icon(index , first_item_selected_info[2])
		first_item_selected = false
		
	hotbar.select(selected_item_index)


func _on_get_out_fire_rate_timeout():
	$CanvasLayer/get_out_ammo_reload.hide()
	if get_out_in_hand:
		$CanvasLayer/get_out_ammo.show()
	can_shoot_grenade = true


func _on_you_lose_timer_timeout():
	get_tree().change_scene("res://you_lose_menu.tscn")





func _on_OP_time_timeout():
	$AnimatedSprite/asparagus_gun/Area2D/CollisionShape2D.scale = Vector2.ONE
	can_wear_hat = true
	Global.player_speed /= 1.25
	$AnimatedSprite/hat_wearing.hide()
	if hat_in_hand:
		$AnimatedSprite.play("hold")
		$AnimatedSprite/hat_holding.show()
	Global.OP_mode = false




func _on_paper1_paper_collected():
	paper_on_screen = true
	Global.paper_pause = true
	paper_moving = true
	get_parent().get_node("papers/paper1/paper").z_index = 100
	asparagus_image = get_parent().get_node("papers/paper1/asparagus_image")
	paper = get_parent().get_node("papers/paper1/paper")


func _on_paper2_paper_collected():
	paper_on_screen = true
	Global.paper_pause = true
	paper_moving = true
	get_parent().get_node("papers/paper2/paper").z_index = 100
	asparagus_image = get_parent().get_node("papers/paper2/asparagus_image")
	paper = get_parent().get_node("papers/paper2/paper")


func _on_paper3_paper_collected():
	paper_on_screen = true
	Global.paper_pause = true
	paper_moving = true
	get_parent().get_node("papers/paper3/paper").z_index = 100
	asparagus_image = get_parent().get_node("papers/paper3/asparagus_image")
	paper = get_parent().get_node("papers/paper3/paper")


func _on_paper4_paper_collected():
	paper_on_screen = true
	Global.paper_pause = true
	paper_moving = true
	get_parent().get_node("papers/paper4/paper").z_index = 100
	asparagus_image = get_parent().get_node("papers/paper4/asparagus_image")
	paper = get_parent().get_node("papers/paper4/paper")


func _on_paper5_paper_collected():
	paper_on_screen = true
	Global.paper_pause = true
	paper_moving = true
	get_parent().get_node("papers/paper5/paper").z_index = 100
	asparagus_image = get_parent().get_node("papers/paper5/asparagus_image")
	paper = get_parent().get_node("papers/paper5/paper")



func move_paper_animation(paper , asparagus_image):
	var paper_position = paper.global_position
	var camera_center_position = $Camera2D.global_position
	camera_center_position = $Camera2D.global_position
	if paper_position.distance_to(camera_center_position) < 1:
		asparagus_image.scale = Vector2(0.25 , 0.25)
		paper.scale = Vector2(10,10)
		paper_moving = false
		paper_position = camera_center_position
	else:
		asparagus_image.scale += (Vector2(0.25 , 0.25) - Vector2(asparagus_image.scale.x , asparagus_image.scale.y)) / 25
		paper.scale += (Vector2(10,10) - Vector2(paper.scale.x , paper.scale.y)) / 25
		paper_position += (camera_center_position - paper_position) / 25
	paper.global_position = paper_position
	
	
	asparagus_image.global_position = paper.global_position



func _on_Area2D_area_entered(area):
	if not area.get_parent().aggro:
		area.get_parent().get_node("asparagus_gun_detection").show()


func _on_Area2D_area_exited(area):
	if not area.get_parent().aggro:
		area.get_parent().get_node("asparagus_gun_detection").hide()
