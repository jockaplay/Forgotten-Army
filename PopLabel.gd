extends Node2D

var transparent = Color(1, 1, 1, 0)
var finalPos = Vector2(0, 20)

func _process(delta):
#	$Tween.interpolate_property(self, "position", position.y, finalPos.y, 1, Tween.TRANS_BACK, Tween.EASE_IN)
	$Tween.interpolate_property(self, "modulate", modulate.a, transparent.a, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
