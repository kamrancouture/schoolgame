extends Node2D

var Student_Gun = preload("res://blue_man.tscn")
var Grad = preload("res://zombie.tscn")
var Student = preload("res://student.tscn")
onready var player = get_node("Player")

onready var spawn_1 = get_node("spawn_point_1")
onready var spawn_2 = get_node("spawn_point_2")
onready var spawn_3 = get_node("spawn_point_3")

var rng = RandomNumberGenerator.new()

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
var wave = 0

func _ready():
	rng.randomize()
	randomize()
func _physics_process(delta):
	if wave_going and Global.students_alive == 0:
		wave_going = false
		wave += 1
		$wave_timer.start()


func _on_wave_timer_timeout():
	if wave == 0:
		wave_one()
	elif wave == 1:
		wave_two()










func wave_one():
	Global.students_alive = 1
	wave_going = true
	var student = Student.instance()
	spawn_points.shuffle()
	student.global_position = spawn_points.front().global_position
	add_child(student)

func wave_two():
	for i in 3:
		var student = Student.instance()
		spawn_points.shuffle()
		student.global_position = spawn_points.front().global_position
		add_child(student)

