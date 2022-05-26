extends Control

export(NodePath) var _back_button
onready var back_button = get_node(_back_button) as Control

export(NodePath) var _menu_main
onready var menu_main = get_node(_menu_main) as Control

export(NodePath) var _menu_play
onready var menu_play = get_node(_menu_play) as Control

export(NodePath) var _menu_options
onready var menu_options = get_node(_menu_options) as Control

export(NodePath) var _menu_extra
onready var menu_extra = get_node(_menu_extra) as Control

export(NodePath) var _menu_info
onready var menu_info = get_node(_menu_info) as Control

export(NodePath) var _menu_exit
onready var menu_exit = get_node(_menu_exit) as Control

export(NodePath) var _popout
onready var popout = get_node(_popout) as WindowDialog

enum {MAIN, PLAY, OPTIONS, EXTRA, INFO, EXIT}
var current_menu = MAIN

var twDuration = 0.5
var twInitPos = Vector2(1980, 40)
var twFinalPos = Vector2(-1980, 40)
var twOnScreen = Vector2(0, 40)

func _ready():
	_reset_menu()
	if Global.first_open:
		popout.popup_centered(Vector2(1300, 800))
		Global.first_open = false

func _on_jogar_pressed():
	if current_menu != PLAY:
		var tw = get_node("Tween")
		_closeMenu(tw, menu_play)
		tw.start()
		current_menu = PLAY
		back_button.disabled = false

func _on_exit_pressed():
	if current_menu != EXIT:
		var tw = get_node("Tween")
		_closeMenu(tw, menu_exit)
		tw.start()
		current_menu = EXIT
		back_button.disabled = false

func _on_news_pressed():
	popout.popup_centered(Vector2(1300, 800))

func _on_OPT_pressed():
	if current_menu != OPTIONS:
		var tw = get_node("Tween")
		_closeMenu(tw, menu_options)
		tw.start()
		current_menu = OPTIONS
		back_button.disabled = false

func _on_extra_pressed():
	if current_menu != EXTRA:
		var tw = get_node("Tween")
		_closeMenu(tw, menu_extra)
		tw.start()
		current_menu = EXTRA
		back_button.disabled = false

func _on_info_pressed():
	if current_menu != INFO:
		var tw = get_node("Tween")
		_closeMenu(tw, menu_info)
		tw.start()
		current_menu = INFO
		back_button.disabled = false

func _on_back_pressed():
	if current_menu != MAIN:
		menu_main.grab_focus()
		var tw = get_node("Tween")
		_closeMenu(tw, menu_main)
		tw.start()
		current_menu = MAIN
		back_button.disabled = true

func _closeMenu(tw, select_menu):
	tw.interpolate_property(menu_main, "rect_position", menu_main.rect_position, twFinalPos, twDuration, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	tw.interpolate_property(menu_play, "rect_position", menu_play.rect_position, twFinalPos, twDuration, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	tw.interpolate_property(menu_options, "rect_position", menu_options.rect_position, twFinalPos, twDuration, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	tw.interpolate_property(menu_extra, "rect_position", menu_extra.rect_position, twFinalPos, twDuration, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	tw.interpolate_property(menu_info, "rect_position", menu_info.rect_position, twFinalPos, twDuration, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	tw.interpolate_property(menu_exit, "rect_position", menu_exit.rect_position, twFinalPos, twDuration, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	tw.interpolate_property(select_menu, "rect_position", twInitPos, twOnScreen, twDuration, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)

func _reset_menu():
	menu_play.rect_position = twFinalPos
	menu_options.rect_position = twFinalPos
	menu_extra.rect_position = twFinalPos
	menu_info.rect_position = twFinalPos
	menu_exit.rect_position = twFinalPos

func _on_confirmExit_pressed():
	get_tree().quit()

func _on_cancelExit_pressed():
	if current_menu != MAIN:
		var tw = get_node("Tween")
		_closeMenu(tw, menu_main)
		tw.start()
		current_menu = MAIN
		back_button.disabled = true
