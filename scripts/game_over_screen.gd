extends Control

@onready var quit: Button = $Panel/Quit
@onready var retry: Button = $Panel/Retry
@onready var return_to_main_menu: Button = $Panel/ReturnToMainMenu


func _on_return_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn") # Replace with function body.
