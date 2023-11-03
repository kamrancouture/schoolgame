extends Node

var gun = preload("res://Assets/kenney_top-down-shooter/PNG/weapon_machine_icon_bigger.png")
var dog = preload("res://Assets/dog_icon_fixed.png")
var get_out = preload("res://Assets/get_out_icon_proper_size2.png")

var player_alive = true
var player_speed = 0
var duck_hunt_defeated = false
var duck_hunt_highscore = 57060
var player_previous_position = null
var player_previous_world = null
var XP = 0

var get_out_picked_up = false
var gun_picked_up = false
var dog_picked_up = false

var player_hotbar = null

var world = "starting_room"

var students_alive = 0


var player_items_cheat = ["gun", gun, false, "dog", dog, false, "item", null, false, "get_out", get_out, false, "item", null, false, "item", null, false, "item", null, false, "item", null, false, "item", null, false]



func _physics_process(delta):
	if Input.is_action_just_pressed("f2"):
		get_tree().change_scene("res://computer_class.tscn")
		world = "computer_class"
	if Input.is_action_just_pressed("f3"):
		get_tree().change_scene("res://high_tech_hop.tscn")
		world = "high_tech_hop"
