extends Node2D


func change():
	Global.killedCol = 0
	Global.colmNumber = 0
	var _a = get_tree().change_scene("res://Assets/Worlds/World_01.tscn")

func _input(event):
	if !event is InputEventMouseMotion:
		_fade()
		
func _fade():
	$AnimationPlayer2.play("transition")
