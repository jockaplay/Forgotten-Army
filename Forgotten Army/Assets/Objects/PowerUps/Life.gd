extends Area2D

var time = 0

func _physics_process(delta):
	time += delta
	$AnimatedSprite.scale.x = (abs(sin(time * 2)) + 1) / 1.7
	$AnimatedSprite.scale.y = (abs(sin(time * 2)) + 1) / 1.7

func _on_Area2D_body_entered(body):
	queue_free()
