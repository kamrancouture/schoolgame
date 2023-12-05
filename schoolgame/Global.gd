extends Node



var gun = preload("res://Assets/gun_icon_fixed_fixed.png")
var dog = preload("res://Assets/dog_icon_fixed.png")
var get_out = preload("res://Assets/get_out_icon_proper_size2.png")
var hat = preload("res://Assets/high_hop_hat_icon.png")
var player_alive = true
var player_speed = 0
var duck_hunt_defeated = false
var duck_hunt_highscore = 57060
var player_previous_position = null
var player_previous_world = null
var XP = 0
var visited_high_hop = false

var asparagus_gun_picked_up = false
var hat_picked_up = false
var gun_picked_up = false
var get_out_picked_up = false
var dog_picked_up = false

var player_hotbar = null

var world = "starting_room"
var player_health_for_insane_mode = 0
var difficulty = "normal"
var students_alive = 0
var volume = -32.5
var player_items_cheat = ["gun", gun, false, "dog", dog, false, "item", null, false, "get_out", get_out, false, "hat", hat, false, "item", null, false, "item", null, false, "item", null, false, "item", null, false]

var OP_mode = false
var numbers_of_death_high_hop = 0
var paper_number = 0
var paper_pause = false

func restart():
	visited_high_hop = false
	numbers_of_death_high_hop = 0
	player_alive = true
	world = "starting_room"
	player_previous_world = null
	player_previous_position = null
	gun_picked_up = false
	paper_number = 0
	XP = 0
	get_out_picked_up = false
	duck_hunt_defeated = false
	duck_hunt_highscore = 0
	dog_picked_up = false
	player_hotbar = null


func _physics_process(delta):
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master") , volume)
	
	if Input.is_action_just_pressed("f2"):
		get_tree().change_scene("res://computer_class.tscn")
		world = "computer_class"
	if Input.is_action_just_pressed("f3"):
		get_tree().change_scene("res://high_tech_hop.tscn")
		world = "high_tech_hop"
	if Input.is_action_just_pressed("f4"):
		get_tree().change_scene("res://asparagus_world.tscn")
		world = "asparagus_world"
	if Input.is_action_just_pressed("f5"):
		get_tree().change_scene("res://aspara-gus_world.tscn")
		world = "aspara_gus_world"
