extends Node2D


func change():
	Global.killedCol = 0
	Global.colmNumber = 0
	var _a = get_tree().change_scene("res://Assets/Worlds/World_01.tscn")