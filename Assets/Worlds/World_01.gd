extends Node2D

export var mission : int = 0

func _ready():
	Global.killedCol = 0

func _process(_delta):
	if Global.killedCol >= mission:
		var _a = get_tree().change_scene("res://Assets/Worlds/cutscene/Cutscene1.tscn")
