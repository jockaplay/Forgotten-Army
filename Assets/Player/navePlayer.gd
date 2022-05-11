extends KinematicBody2D

var speed = 95
var vida = 10
var maxVida = 10
var power = 5
var maxipower = 15
var boost = false
var time = 0
var cooldown = false
var cooldownTime = 0.3
onready var bullet = preload("res://Assets/Player/spells/bullet.tscn")
onready var cam = get_node("Camera")
onready var hpbar = get_node("../CanvasLayer/TextureProgress")
onready var boostBar = get_node("../CanvasLayer/power")

func _ready():
	boostBar.max_value = maxipower
	$cooldown.wait_time = cooldownTime
	
func _physics_process(delta):
	hpbar.max_value = maxVida
	vida = clamp(vida, 0, maxVida)
	get_parent().get_node("CanvasLayer/RichTextLabel").bbcode_text = "colmeias: " + str(Global.killedCol) + "/" + str(Global.colmNumber)
	hpbar.value = vida
	boostBar.value = power
	boosty(delta, maxipower)
	applyBoost(160)
	changeBarColor()
	var velocity = Vector2.ZERO
	look_at(get_global_mouse_position())
	velocity = (get_global_mouse_position() - position).normalized() * speed * Input.get_action_strength("foward")
	if Input.is_action_pressed("shoot"):
		if !cooldown:
			shoot()
			$cooldown.start()
	var _mv = move_and_slide(velocity)
	if vida <= 0:
		var _menu = get_tree().change_scene("res://Assets/Worlds/Menus/Main.tscn")
	
func _input(_event):
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

func boosty(delta, _maxvalue):
	power = clamp(power, 0, _maxvalue)
	time += delta
#	if time > 1:
	if boost == true:
		cam.zoom = lerp(cam.zoom, Vector2(0.75, 0.75), 0.2 * delta * 20)
		power -= 0.05
	else:
		cam.zoom = lerp(cam.zoom, Vector2(0.6, 0.6), 0.2 * delta * 20)
		power += 0.05
	time = 0

func _on_cooldown_timeout():
	cooldown = false

func changeBarColor():
	if vida < (maxVida / 3):
		hpbar.tint_progress = Color(1, 0, 0)
	elif vida < (maxVida / 1.8):
				hpbar.tint_progress = Color(1, 1, 0)
	else:
		hpbar.tint_progress = Color(0, 1, 0)
		
func hit(damage):
	vida -= damage
