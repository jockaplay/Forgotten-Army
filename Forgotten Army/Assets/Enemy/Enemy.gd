extends KinematicBody2D
class_name Enemy

onready var target = get_parent().get_node("navePlayer")
#onready var drop = preload()
export var speed = 1
export var life = 1
var time = 0
export var distanceToPlayer = 1
var distanceToRun = 85
var following = true
var run = false

func _ready():
	randomize()
	self.time = rand_range(1, 3)

func _physics_process(delta):
	time += delta
	var velocity = Vector2.ZERO
	var distance = 0
	look_at(target.global_position)
	distance = position.distance_to(target.position)
	if distance < distanceToPlayer:
		following = false
		run = false
	if distance > distanceToPlayer + 40:
		time = 0
		following = true
	if distance < distanceToRun:
		run = true
	if !following and !run:
		self.position -= transform.y * sin(time)
#		self.position -= transform.x * abs(cos(time))
#		velocity.x += (sin(time) * rand_range(2, 10))
#		velocity.y -= (cos(time) * rand_range(2, 10))
	if following and !run:
		velocity = (target.position - position).normalized() * speed
	if !following and run:
		time = 0
		velocity -= transform.x * speed
	move_and_slide(velocity)
	death()

func hit(value):
	life -= value
	
func death():
	if life <= 0:
		queue_free()
