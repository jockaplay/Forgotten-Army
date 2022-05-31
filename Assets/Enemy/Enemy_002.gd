extends Enemy

var timeb = 0
var distance = 0

export(PackedScene) var _bullet
onready var bullet = _bullet

export(PackedScene) var _partc
onready var partc = _partc

func _physics_process(delta):
	if target != null:
		timeb += delta
		distance = position.distance_to(target.position)
		if distance <= 450:
			if $body.frame == 14:
				if timeb >= 0.5:
					shoot()
		if life <= 0:
			var a = partc.instance()
			a.emitting = true
			a.get_node("Particles2D").emitting = true
			a.global_position = global_position
			death(a)
			
func shoot():
	var b = bullet.instance()
	b.damage = 1
	b.rotation_degrees = rotation_degrees
	b.global_position = global_position
	b.modulate = Color(1, 0.403922, 0.364706)
	get_parent().call_deferred("add_child", b)
	timeb = 0
