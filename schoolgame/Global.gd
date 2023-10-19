extends Node

var player_alive = true
var gun_picked_up = false
var player_speed = 0
var duck_hunt_defeated = false
var duck_hunt_highscore = 5706
var player_previous_position = null
var player_previous_world = null
var XP = 0

var dog_picked_up = false
var player_hotbar = null

var world = "starting_room"

var students_alive = 0

func _physics_process(delta):
	if Input.is_action_just_pressed("f2"):
		get_tree().change_scene("res://computer_class.tscn")
		world = "computer_class"
