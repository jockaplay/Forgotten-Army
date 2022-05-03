extends Enemy

var timeb = 0
var distance = 0
onready var bullet = preload("res://Assets/Enemy/skills/bulletEnemy.tscn")

func _physics_process(delta):
	timeb += delta
	distance = position.distance_to(target.position)
	if distance <= 450:
		if $body.frame == 14:
			if timeb >= 0.5:
				shoot()
			
func shoot():
	var b = bullet.instance()
	b.damage = 1
	b.rotation_degrees = rotation_degrees
	b.global_position = global_position
	get_parent().call_deferred("add_child", b)
	timeb = 0
