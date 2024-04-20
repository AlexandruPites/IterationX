extends Area2D
class_name Projectile

var velocity : Vector2 = Vector2(1000, 0)

func _process(delta: float) -> void:
	position += velocity * delta
