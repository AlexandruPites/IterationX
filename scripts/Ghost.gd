extends Sprite2D
class_name Ghost

var tween : Tween

func _ready() -> void:
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.2)
	
	await tween.finished
	queue_free()
