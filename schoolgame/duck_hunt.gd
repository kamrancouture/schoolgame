extends Node2D

var dog_texture = preload("res://icon.png")
var restarting = false
var lives = 5
var score = 0
var Duck = preload("res://duck.tscn")
var crosshair = preload("res://Assets/kenney_crosshair-pack/PNG/Outline Retina/crosshair037.png")

var rng = RandomNumberGenerator.new()

var duck_move_right = [
	true,
	false
]

func _ready():
	$AnimationPlayer.play("dog_laughing")
	randomize()
	rng.randomize()
	Input.set_custom_mouse_cursor(crosshair , Input.CURSOR_ARROW , Vector2(72 , 72))

func _physics_process(delta):
	
	if not restarting:
		$mistake_panel/CenterContainer/mistakes_left.text = String(lives)
	
	if lives <= 0 and not restarting:
		restarting = true
		$restart_timer.start()
	
	$Timer.wait_time *= .999
	
	if Input.is_action_just_pressed("shoot"):
		$shoot.play()
	$Score_panel/CenterContainer/Score.text = String(score)

func _on_Timer_timeout():
	if not restarting:
		var duck = Duck.instance()
		duck.global_position.y = rng.randf_range(200,570)
		duck_move_right.shuffle()
		duck.moving_right = duck_move_right.front()
		add_child(duck)

func restart():
	restarting = false
	lives = 5
	score = 0
	$Timer.wait_time = 3

func _on_left_wall_area_entered(area):
	if not area.moving_right:
		area.queue_free()
		lives -= 1


func _on_right_wall_area_entered(area):
	if area.moving_right:
		area.queue_free()
		lives -= 1


func _on_restart_timer_timeout():
	
	if score > Global.duck_hunt_highscore:
		Global.duck_hunt_highscore = score
	
	if score < Global.duck_hunt_highscore or Global.duck_hunt_defeated:
		restart()
	else:
		recieve_dog()
		Global.XP += 90
		$text_popups/you_won.pop_up()
		$AnimationPlayer.stop()
		$AnimationPlayer.play("dog_happy")
		Global.duck_hunt_defeated = true
		restart()
		$fake_player_hotbar


func _on_TextureButton_button_down():
	if Global.duck_hunt_defeated:
		get_tree().change_scene("res://starting_room.tscn")
	else:
		$text_popups/cant_leave_yet.pop_up()


func recieve_dog():
	$fake_player_hotbar.items = Global.player_hotbar
	var lowest_non_selected_found = false
	var hotbar_number_checking = 1
	var lowest_non_selected : int
	
	if not Global.dog_picked_up:
		Global.dog_picked_up = true
		while not lowest_non_selected_found:
			if $fake_player_hotbar.get_item_icon(hotbar_number_checking-1) == null:
				lowest_non_selected_found = true
			else:
				hotbar_number_checking += 1
		$fake_player_hotbar.set_item_icon(hotbar_number_checking - 1 , dog_texture)
		$fake_player_hotbar.set_item_text(hotbar_number_checking - 1 , "dog")
		Global.player_hotbar = $fake_player_hotbar.items

