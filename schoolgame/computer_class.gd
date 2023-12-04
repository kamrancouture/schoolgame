extends Node2D

var Grad = preload("res://zombie.tscn")
var Student = preload("res://student.tscn")
onready var player = get_node("Player")

onready var spawn_1 = get_node("spawn_point_1")
onready var spawn_2 = get_node("spawn_point_2")
onready var spawn_3 = get_node("spawn_point_3")

onready var spawn_points =[
	spawn_1,
	spawn_2,
	spawn_3
]

onready var no_gun_human =[
	Student,
	Grad,
]


var wave_going = false
var wave = 1

func _ready():
	player.get_node("CanvasLayer/new_world_animation/world_label").text = "Computer Class"
	player.get_node("CanvasLayer/new_world_animation/AnimationPlayer").play("fade_out_label")
	
func _physics_process(delta):
	if wave_going and Global.students_alive == 0:
		wave_going = false
		wave += 1
		Global.XP += 10 * wave
		$wave_timer.start()


func _on_wave_timer_timeout():
	if wave == 1:
		wave_one()
	elif wave == 2:
		wave_two()
	elif wave == 3:
		wave_three()
	elif wave == 4:
		wave_four()
		grenade_spawn()
	elif wave == 5:
		wave_five()
	elif wave == 6:
		$high_tech_hop_portal/cole.show()
		$high_tech_hop_portal.enabled = true





func grenade_spawn():
	$get_out_Pickup.enabled = true
	$get_out_pickup_sprite.show()


func wave_one():
	Global.students_alive = 1
	wave_going = true
	var student = Student.instance()
	spawn_points.shuffle()
	student.global_position = spawn_points.front().global_position
	add_child(student)

func wave_two():
	Global.students_alive = 3
	wave_going = true
	for i in 3:
		$delay_spawn_timer.start()
		yield($delay_spawn_timer , "timeout")
		var student = Student.instance()
		spawn_points.shuffle()
		student.global_position = spawn_points.front().global_position
		add_child(student)

func wave_three():
	Global.students_alive = 3
	wave_going = true
	for i in 3:
		$delay_spawn_timer.start()
		yield($delay_spawn_timer , "timeout")
		var grad = Grad.instance()
		spawn_points.shuffle()
		grad.global_position = spawn_points.front().global_position
		add_child(grad)

func wave_four():
	Global.students_alive = 6
	wave_going = true
	for i in 3:
		$delay_spawn_timer.start()
		yield($delay_spawn_timer , "timeout")
		var grad = Grad.instance()
		spawn_points.shuffle()
		grad.global_position = spawn_points.front().global_position
		add_child(grad)
		
	for i in 3:
		$delay_spawn_timer.start()
		yield($delay_spawn_timer , "timeout")
		var student = Student.instance()
		spawn_points.shuffle()
		student.global_position = spawn_points.front().global_position
		add_child(student)

func wave_five():
	Global.students_alive = 15
	wave_going = true
	for i in 15:
		$delay_spawn_timer.start()
		yield($delay_spawn_timer , "timeout")
		var student = Student.instance()
		spawn_points.shuffle()
		student.global_position = spawn_points.front().global_position
		add_child(student)




