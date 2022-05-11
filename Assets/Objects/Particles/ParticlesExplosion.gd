extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Particles2D2.emitting = true
	$Particles2D2.one_shot = true
func _process(delta):
	var time = 0
	time += delta
	if time >= 1:
		queue_free()
