extends Node2D

onready var player = get_node("Player")

func _ready():
	if Global.gun_picked_up:
		$gun_pickup_sprites.hide()
		$Gun_Pickup.queue_free()
	if Global.duck_hunt_defeated:
		player.gun_in_hand = true
		player.get_node("AnimatedSprite").play("pistol")
	
	Input.set_custom_mouse_cursor(null)
	$dead_ducks.hide()

func _physics_process(delta):
	if Global.duck_hunt_defeated:
		$dead_ducks.show()

