extends Control

@onready var settings: Control = $ColorRect/Settings
@onready var panel: Panel = $ColorRect/Panel

@onready var button_back: Button = $ColorRect/Settings/CenterContainer/PanelContainer/MarginContainer/ScrollContainer/VBoxContainer/ButtonBack
@onready var resume: Button = $ColorRect/Panel/Resume
@onready var timer: Timer = get_node("/root/Game/Camera2D/Timer")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_on_resume_pressed()
	

func _on_settings_pressed() -> void:
	panel.visible = false
	settings.visible = true
	button_back.grab_focus.call_deferred()


func _on_resume_pressed() -> void:
	panel.visible = false
	settings.visible = false
	get_tree().paused = not get_tree().paused
	get_parent().delete_instance(self)


func _on_save_pressed() -> void:
	get_tree().paused = not get_tree().paused
	save_utils.save_currency(timer.wait_time - timer.time_left)
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_button_back_pressed() -> void:
	settings.visible = false
	panel.visible = true
	resume.grab_focus.call_deferred()
