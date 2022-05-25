extends Node2D

export var mission : int = 0


func _process(_delta):
	if Global.killedCol >= mission:
		Global.killedCol = 0
		var _a = get_tree().change_scene("res://Assets/Worlds/cutscene/Cutscene1.tscn")
