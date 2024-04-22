extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func resume() -> void:
	get_tree().paused = not get_tree().paused
	get_parent().delete_instance(self)

func _on_choice_1_pressed() -> void:
	print("choice1")
	resume()

func _on_choice_2_pressed() -> void:
	print("choice2")
	resume()

func _on_choice_3_pressed() -> void:
	print("choice3")
	resume()
