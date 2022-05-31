extends KinematicBody2D

export var speed = 95
export var vida = 10
var maxVida = 10
var power = 5
var maxipower = 15
var boost = false
export(int) var _boost_speed
var time = 0
var cooldown = false
var cooldownTime = 0.3
var velocity = Vector2.ZERO

"""  debug  """

export(bool) var _imortal
onready var imortal = _imortal

"""  debug  """

export(PackedScene) var _bullet
onready var bullet = _bullet

export(NodePath) var _cam
onready var cam = get_node(_cam) as Camera2D

export(NodePath) var _hp_bar
onready var hpbar = get_node(_hp_bar) as TextureProgress

export(NodePath) var _boost_bar
onready var boostBar = get_node(_boost_bar) as TextureProgress

export(NodePath) var _bbcode
onready var bbcode = get_node(_bbcode) as RichTextLabel

func _ready():
	boostBar.max_value = maxipower
	$cooldown.wait_time = cooldownTime
	
func _physics_process(delta):
	bbcode.bbcode_text = "colmeias: " + str(Global.killedCol) + "/" + str(Global.colmNumber)
	boostBar.value = power
	boosty(delta, maxipower)
	applyBoost(_boost_speed)
	changeBarColor()
	shoot()
	_set_hp_settings()
	look_at(get_global_mouse_position())
	velocity = (get_global_mouse_position() - position).normalized() * speed * Input.get_action_strength("foward")
	if vida <= 0:
		var _menu = get_tree().change_scene("res://Assets/Worlds/Menus/Main.tscn")
	var _mv = move_and_slide(velocity)
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_DELETE:
			imortal = !imortal
	if Input.is_action_just_pressed("boost"):
#		power -= 1
		time = 0
		if !boost:
			boost = true
		else:
			boost = false

func shoot():
	if Input.is_action_pressed("shoot"):
		if !cooldown:
			cooldown = true
			var b = bullet.instance()
			b.rotation_degrees = rotation_degrees
			b.global_position = $MainGun.global_position
			get_parent().call_deferred("add_child", b)
			$cooldown.start()

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
		cam.zoom = lerp(cam.zoom, Vector2(0.65, 0.65), 0.2 * delta * 20)
		power -= 0.05
	else:
		cam.zoom = lerp(cam.zoom, Vector2(0.45, 0.45), 0.2 * delta * 20)
		power += 0.05
	time = 0

func _on_cooldown_timeout():
	cooldown = false

func _set_hp_settings():
	vida = clamp(vida, 0, maxVida)
	hpbar.max_value = maxVida
	hpbar.value = vida

func changeBarColor():
	if vida < (maxVida / 3):
		hpbar.tint_progress = Color(1, 0, 0)
	elif vida < (maxVida / 1.8):
				hpbar.tint_progress = Color(1, 1, 0)
	else:
		hpbar.tint_progress = Color(0, 1, 0)
		
func hit(damage):
	if !imortal:
		vida -= damage
