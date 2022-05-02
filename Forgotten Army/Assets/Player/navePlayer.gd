extends KinematicBody2D

var speed = 95
var power = 5
var maxipower = 5
var boost = false
var time = 0
var cooldown = false
var cooldownTime = 0.4
onready var bullet = preload("res://Assets/Player/spells/bullet.tscn")

func _ready():
	$cooldown.wait_time = cooldownTime
	
func _physics_process(delta):
	get_parent().get_node("CanvasLayer/TextureProgress").value = power
	get_parent().get_node("CanvasLayer/TextureProgress").max_value = maxipower
	boost(delta, maxipower)
	applyBoost(160)
	changeBarColor()
	var velocity = Vector2.ZERO
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("foward"):
		velocity = (get_global_mouse_position() - position).normalized() * speed
	if Input.is_action_pressed("shoot"):
		if !cooldown:
			shoot()
			$cooldown.start()
	move_and_slide(velocity)
	
func _input(event):
	if Input.is_action_just_pressed("boost"):
#		power -= 1
		time = 0
		if !boost:
			boost = true
		else:
			boost = false

func shoot():
	cooldown = true
	var b = bullet.instance()
	b.rotation_degrees = rotation_degrees
	b.global_position = $MainGun.global_position
	get_parent().call_deferred("add_child", b)
	pass

func applyBoost(value:int):
	if boost == true:
		speed = value
	else:
		speed = 95
	if power <= 0:
		boost = false

func boost(delta, maxvalue):
	power = clamp(power, 0, maxvalue)
	time += delta
#	if time > 1:
	if boost == true:
		power -= 0.05
	else:
		power += 0.05
	time = 0

func _on_cooldown_timeout():
	cooldown = false

func changeBarColor():
	if power < (maxipower / 3):
		$"../CanvasLayer/TextureProgress".tint_progress = Color(1, 0, 0)
	elif power < (maxipower / 1.8):
				$"../CanvasLayer/TextureProgress".tint_progress = Color(1, 1, 0)
	else:
		$"../CanvasLayer/TextureProgress".tint_progress = Color(0, 1, 0)
		
