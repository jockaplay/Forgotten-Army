extends KinematicBody2D

var life = 20
var time = 0
var timeToSpawn = 0
onready var nave1 = preload("res://Assets/Enemy/Enemy_001.tscn")

func _ready():
	timeToSpawn = rand_range(3, 10)
	$Timer.start(timeToSpawn)

func _physics_process(delta):
	time += (delta / 1.2)
	rotation_degrees += sin(time / 2)
	if life <= 0:
		death()
	
func hit(value):
	life -= value

func death():
	queue_free()


func _on_Timer_timeout():
	timeToSpawn = rand_range(3, 10)
	var a = nave1.instance()
	a.global_position = global_position
	get_parent().call_deferred("add_child", a)
	$Timer.start(timeToSpawn)
