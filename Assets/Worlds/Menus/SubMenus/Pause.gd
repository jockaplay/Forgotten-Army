extends Control

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_P:
			get_tree().paused = !get_tree().paused
			visible = !visible

func _on_voltar_pressed():
	get_tree().paused = !get_tree().paused
	visible = !visible

func _on_sair_pressed():
	get_tree().paused = !get_tree().paused
	var _menu = get_tree().change_scene("res://Assets/Worlds/Menus/Main.tscn")
