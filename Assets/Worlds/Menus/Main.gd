extends Control

func _ready():
	$PopupDialog.popup_centered(Vector2(800, 512))

func _on_Button_pressed():
	var _a = get_tree().change_scene("res://Assets/Worlds/cutscene/Cutscene1.tscn")

func _on_Button2_pressed():
	get_tree().quit()
