extends Enemy

var timeb = 0
var distance = 0
var reload = 0
onready var bullet = preload("res://Assets/Enemy/skills/bulletEnemy.tscn")
onready var partc = preload("res://Assets/Objects/Particles/ParticlesExplosion.tscn")

func _ready():
	randomize()
	reload = (randi() % 5 + 1) + 5

func _process(delta):
	timeb += delta
	distance = position.distance_to(target.position)
	if distance <= 450:
		if $body.frame == 4:
			if timeb >= reload:
				shoot()
	if life <= 0:
		var a = partc.instance()
		a.emitting = true
		a.get_node("Particles2D").emitting = true
		a.global_position = global_position
		death(a)

func shoot():
	var b = bullet.instance()
	b.damage = 0.5
	b.rotation_degrees = rotation_degrees
	b.global_position = global_position
	b.modulate = Color(0, 0.694118, 0.258824)
	get_parent().call_deferred("add_child", b)
	timeb = 0
