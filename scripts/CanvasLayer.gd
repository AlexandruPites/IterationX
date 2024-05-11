extends CanvasLayer
@onready var settings: Control = $Settings
@onready var main_menu: Control = $Main
@onready var injector: Control = $Injector

@onready var button_back: Button = $Settings/CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/ButtonBack
@onready var button_play: Button = $Main/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonPlay
@onready var button_injector: Button = $Main/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonInjector
@onready var back_from_injector_to_main: Button = $Injector/BackFromInjectorToMain


func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")


func _on_button_settings_pressed() -> void:
	main_menu.visible = false
	settings.visible = true 
	button_back.grab_focus.call_deferred()


func _on_button_quit_pressed() -> void:
	get_tree().quit()



func _on_button_back_pressed() -> void:
	main_menu.visible = true
	settings.visible = false
	button_play.grab_focus.call_deferred()


func _on_button_injector_pressed() -> void:
	main_menu.visible = false
	injector.visible = true


func _on_back_from_injector_to_main_pressed() -> void:
	main_menu.visible = true
	injector.visible = false
	button_play.grab_focus.call_deferred()

