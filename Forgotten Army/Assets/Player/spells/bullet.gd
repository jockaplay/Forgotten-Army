extends Area2D

var damage = 1
var speed = 5

func _physics_process(delta):
	position += transform.x * speed

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	

func _on_Area2D_body_entered(body):
	body.hit(damage)
	queue_free()
	
