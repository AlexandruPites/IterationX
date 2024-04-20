extends Area2D
class_name Projectile

var velocity : Vector2 = Vector2(500, 0)
var damage : float = 10.0

func _process(delta: float) -> void:
	position += velocity * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("damageable"):
		var direction : Vector2 = global_position.direction_to(body.global_position).normalized()
		body.take_damage(damage, direction)
		queue_free()
