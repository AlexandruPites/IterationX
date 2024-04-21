extends Control

@onready var settings: Control = $ColorRect/Settings
@onready var panel: Panel = $ColorRect/Panel

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_on_resume_pressed()
	

func _on_settings_pressed() -> void:
	panel.visible = false
	settings.visible = true


func _on_resume_pressed() -> void:
	panel.visible = false
	settings.visible = false
	get_tree().paused = not get_tree().paused
	get_parent().delete_instance(self)


func _on_save_pressed() -> void:
	pass

func _on_button_back_pressed() -> void:
	settings.visible = false
	panel.visible = true
	
