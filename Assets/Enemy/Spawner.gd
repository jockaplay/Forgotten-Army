extends KinematicBody2D

var life = 15
var time = 0
var timeToSpawn = 0
var protection = 20
var protectionMax = 20
onready var nave1 = preload("res://Assets/Enemy/Enemy_001.tscn")
onready var text = get_node("Control/protect")

func _ready():
	Global.colmNumber += 1
	timeToSpawn = rand_range(5, 10)
	$Timer.start(timeToSpawn)

func _physics_process(delta):
	protection = clamp(protection, 0, protectionMax)
	text.bbcode_text = "[center]" + str(protection) + "/" + str(protectionMax)
	protection = Global.protectionProgress
	time += (delta / 1.2)
	$body.rotation_degrees += sin(time / 2)
	if life <= 0:
		death()
	$Control/HP.value = life
func hit(value):
	if protection >= protectionMax:
		life -= value

func death():
	Global.killedCol += 1
	queue_free()


func _on_Timer_timeout():
	timeToSpawn = rand_range(3, 10)
	var a = nave1.instance()
	a.global_position = global_position
	get_parent().call_deferred("add_child", a)
	$Timer.start(timeToSpawn)
